# -*- encoding : utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'logger'
class FortumReader

  START_URL = 'https://www.fortum.com/countries/fi/yksityisasiakkaat/omat-palvelut/kulutuksen-seuranta/lukemahistoria/pages/default.aspx'
  AGREEMENTS_URL = 'https://www.fortum.com/countries/fi/yksityisasiakkaat/omat-palvelut/sopimukset/pages/default.aspx'

  def initialize(username, password)
    @rds=[]
    @username=username
    @password=password
    raise "Username and password must exist!" unless @username && @password
    @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  # Check that login works with given params.
  def login_ok?
    new_agent
    welcome_page=login
    welcome_page.uri.to_s.include?("login") ? false : true
  end

  # Read readings! Returns array of readings.
  def read
    new_agent
    @cups=[]
    welcome_page=login
    if welcome_page.uri.to_s.include?("login")
      raise "Cannot read readings: login was not OK. Is there problem with username(#{@username}) and password?"
    end
    select_cup_form=navigate_to_select_cup_page(welcome_page).form
    # read available cups
    read_cups(select_cup_form)
    # Iterate each cup.
    @cups.each_with_index do |cup, index|
      @logger.info "Reading usage point #{index+1} #{cup[:usage_point_id]}..."
      usages_page=navigate_to_usages_page(select_cup_form, index+1, cup[:usage_point_id])
      # Find each page and load readings
      usages_page.links.each do |link|
        if link.href.include?("ReadingReport")
          reading_page=link.click
          @logger.info "Reading from page with title '#{link.text.chomp}'"
          collect_readings(reading_page, cup[:usage_point_id])
        end
      end

      if index < @cups.size-1
        logout
        welcome_page=login
        select_cup_form=navigate_to_select_cup_page(welcome_page).form
      end
    end
    @logger.info "Ready! Got #{@rds.size} readings."
    @rds
  end

  def logout
    @agent=nil
  end

  def readings
    @rds
  end

  # Reads basic information for customer targets. Example address. Returns hash.
  def basic_information
    vals={}

    new_agent
    welcome_page=login(AGREEMENTS_URL)
    bodypage=welcome_page.iframe.click
    ps=bodypage.search("//p")
    ps.each do |node|
      if node.text.include?("Käyttöpaikka:")
        parts=node.text.split("\n")
        vals[:street_address]=parts[1].chomp.strip
        vals[:postno]=parts[2].chomp.strip
        vals[:city]=parts[3].chomp.strip.capitalize
      end
    end

    vals
  end

  # Reads usage point information. Returns list of usage point information hashes.
  def usage_point_information
    list=[]
    # TODO: Implement
    list
  end

  # Nagigagtes from welcome page to select cup page.
  def navigate_to_select_cup_page(welcome_page)
    lukemahistoria_page=welcome_page.link_with(text: "Lukemahistoria").click
    select_cup_page=lukemahistoria_page.iframe.click
    select_cup_page
  end

  def new_agent
    @agent=Mechanize.new
    @agent.user_agent_alias="Linux Firefox"
    @agent
  end

  def agent
    new_agent unless @agent
    @agent
  end

  # Logins user. Return page after login.
  def login(url= START_URL)
    page=agent.get(url)
    login_form=page.form
    login_form.username=@username
    login_form.password=@password
    page=agent.submit(login_form)
    @logger.info "After login, result page url is #{page.uri}"
    page
  end

  def read_cups(select_cup_form)
    @cups=[]
    @logger.info "Reading usage point information..."
    select_cup_form.page.search("//table//tr").each_with_index do |cup, index|
      infos=cup.children[1].text.gsub(/\r\n/m, "\n").split("\n")
      @cups<<{usage_point_id: infos[1].strip, street_address: infos[2].strip, postno: infos[3].strip, city: infos[4].strip}
    end
    @logger.info "Found #{@cups.size} usage points."
  end

  def navigate_to_usages_page(select_cup_form, no, usage_point_id)
    @logger.info "Reading usage point #{usage_point_id} readings..."
    select_cup_form.radiobuttons[no-1].check
    #select_cup_form["cmdSelectCP"]="Jatka"
    usages_page=select_cup_form.click_button
    raise "error: submit select did not work." if usages_page.content.include?("Valitse k")
    raise "error: Did not get given usage_point_id #{usage_point_id} page." unless usages_page.content.include?(usage_point_id)
    usages_page
  end

  def collect_readings(page, usage_point_id)
    readings=page.search("//tr[@name='NormalRow']") + page.search("//tr[@name='HighLightRow']")
    @logger.debug "Got #{readings.size} possible elements for readings..."
    readings.each do |reading|
      if reading.children.size >= 4
        comment=reading.children[1].children.text.chomp
        #@logger.debug "comment is #{comment}"
        reading_hash={read_at: reading.children[0].children.text.chomp,
                      reading: reading.children[3].children.text.chomp,
                      usage_point_id: usage_point_id,
                      comment: reading.children[1].children.text.chomp}
        @logger.info "Reading hash: #{reading_hash}"
        if comment.downcase.include?("siirto") || comment.downcase.include?("kauko")
          @rds<<reading_hash
        else
          @logger.error "Got reading, with unknown comment: #{comment} cannot process."
        end
      end
    end
  end

end

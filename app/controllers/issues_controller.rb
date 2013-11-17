require 'xmlrpc/client'

class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @result = testapi
    render :json => @result
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    render :json => {'issue1' => {'subject' => 'foo', 'end_at' => '2013-11-18'},
                     :issue2 => {'subject' => 'bar', 'end_at' => '2013-11-19'},
                     :issue3 => {'subject' => 'hoge', 'end_at' => '2013-12-3'}}
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      #@issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params[:issue]
    end

    def testapi
      host = 'kanban.backlog.jp'
      path = '/XML-RPC'
      port = '443'
      proxy_host = nil
      proxy_port = nil
      user = 'api'
      password = 'api1117'
      use_ssl = true
      timeout = 60

      client = XMLRPC::Client.new(host, path, port, proxy_host, proxy_port, user, password, use_ssl, timeout)

      begin
        #プロジェクト情報が表示される
        #result = client.call('backlog.getProject', プロジェクト番号)

        #ユーザー情報が表示される
        #result = client.call('backlog.getUsers', ユーザー番号 )

        #自分のタイムラインが表示される（重い）
        #result = client.call('backlog.getTimeline')
        result = client.call('backlog.findIssue', {'projectId' => 1073817496})

      rescue XMLRPC::FaultException => e
        puts "fault #{e.faultCode}: #{e.faultString}"
      end
    end

end

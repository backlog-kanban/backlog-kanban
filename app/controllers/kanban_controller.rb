class KanbanController < ApplicationController
  require 'xmlrpc/client'

  def index
    @result = testapi
  end

  private
    def testapi
      host = BacklogKanban::Application.config.host
      path = '/XML-RPC'
      port = '443'
      proxy_host = nil
      proxy_port = nil
      user = BacklogKanban::Application.config.user
      password = BacklogKanban::Application.config.password
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

        client.call('backlog.findIssue', {'projectId' => BacklogKanban::Application.config.project_id})

      rescue XMLRPC::FaultException => e
        puts "fault #{e.faultCode}: #{e.faultString}"
      end
    end
end

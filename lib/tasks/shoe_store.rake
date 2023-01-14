namespace :shoe_store do
    desc "Pull websocket events"
    task pull_events: :environment do
        EM.run {
            ws_conn = Faye::WebSocket::Client.new(ENV['WEBSOCKET_URL'])

            ws_conn.on :message do |event|
                p JSON.parse(event.data)
                begin
                    SalesJob.perform_async(event.data)
                rescue => e
                    p e
                    p "invalid json event sale : #{event.data}"
                end
            end

            ws_conn.on :close do |event|
                p [:close, event.code, event.reason]
                ws_conn = nil
            end
        }
    end
end

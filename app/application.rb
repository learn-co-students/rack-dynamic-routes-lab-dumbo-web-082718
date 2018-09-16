class Application

  @@items = [Item.new("Figs",3.42),
            Item.new("Pears",0.99)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #
    # display all items - iterate through the array (@@items) and
    # write out the price of the items
    # @@items.each do |item|
    #   resp.write "#{item.price}\n"
    # end
  # Expected result:
  #  http://127.0.0.1:9292/items/Figs => writes out 3.42
  # http://127.0.0.1:9292/items/Pears => writes out 0.99
    # if req.path=="/items/Figs"
    #   resp.write @@items[0].price
    # elsif req.path == "/items/Pears"
    #   resp.write @@items[1].price
    # end

    if req.path.match(/items/)
      # #last - last element in an array
      # #
      # item_price = req.path.split("/items/").last #turn /items/Figs into Figs
      item_name = req.path.split("/items/").last #turn /items/Figs into Figs

      # #find - Passes each entry in enum to block. Returns the first for which block is not false.
      # #find example -  (1..10).find {|i| i % 5 == 0 and i % 7 == 0 }
      if item = @@items.find{|i| i.name == item_name}
          resp.write item.price
        else
          resp.write "Item not found"
          resp.status = 400
        end

    else
      #resp.write "Item not found"

      resp.write "Route not found" #works
      resp.status = 404 #works

    end

    resp.finish
  end
end

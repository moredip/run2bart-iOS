module IPhone
  class DeparturesScreen
    include Frank::Cucumber::FrankHelper

    def departure_etds_for_destination(dest)
      selector = %Q|tableViewCell view:'UILabel' marked:'#{dest}' parent tableViewCell view:'UITableViewLabel'|
      frankly_map( selector, 'text' )
    end

    def has_departure(params)
      etds = departure_etds_for_destination(params[:destination])
      !!etds.grep( /^#{params[:etd]} mins?$/ )
    end
  end
end

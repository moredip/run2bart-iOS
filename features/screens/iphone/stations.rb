module IPhone
  class StationsScreen
    include ScreenMixin

    def search_for_station(station_name)
      wait_for_nothing_to_be_animating

      search_bar_selector = %Q|view:'UISearchBarTextField'|
      touch("view:'UISearchBar'")
      wait_for_keyboard
      type_into_keyboard( station_name )
    end

    def nav_to_station(station_name)
      search_for_station(station_name)
      touch( %Q|tableViewCell FEX_isVisible label marked:'#{station_name}'| )
      wait_for_view_to_disappear( 'Loading' )
    end
  end
end

Deface::Override.new(
  :virtual_path => "admin/configurations/index",
  :name => "currency_exchange_admin_configurations_menu",
  :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
  :text => "<%= configurations_menu_item(t('currency_exchange_settings.title'), admin_currency_settings_path, t('currency_exchange_settings.description')) %>",
  :disabled => false)

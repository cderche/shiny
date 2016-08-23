module = angular.module 'shiny', [
  'pascalprecht.translate'
  'ngCookies'
  'ngAnimate'
]

module.config [
  '$translateProvider'
  ($translateProvider) ->
    $translateProvider.translations 'en', {
      't.liv':         'Livingrooms',
      't.liv_desc':    'Number of livingrooms in your home',
      't.kit':         'Kitchens',
      't.kit_desc':    'Number of kitchens in your home',
      't.bed':         'Bedrooms',
      't.bed_desc':    'Number of bedrooms in your home',
      't.bat':         'Bathrooms',
      't.bat_desc':    'Number of bathrooms in your home',
      't.win':         'Windows',
      't.win_desc':    'Number of windows in your home',
      't.iro':         'Ironing',
      't.iro_desc':    'Approximate number of clothes we should iron',
      't.once':        'Once',
      't.month':       'Once a month',
      't.2weeks':      'Every 2 weeks',
      't.weekly':      'Every week'
    }
    $translateProvider.translations 'ru', {
      't.bed':        'Спальни'
      't.liv':        'Гостиные',
      't.liv_desc':   'Количество гостиных',
      't.kit':        'Кухни',
      't.kit_desc':   'Количество кухонь',
      't.bed':        'спальни',
      't.bed_desc':   'Количество спален',
      't.bat':        'Санузлы',
      't.bat_desc':   'Количество санузлов	',
      't.win':        'Окна',
      't.win_desc':   'Количество окон',
      't.iro':        'Глажка',
      't.iro_desc':   'Приблизительное количество вещей, подлежащих глажке',
      't.once':       'Один раз',
      't.month':      'Раз в месяц',
      't.2weeks':     'Раз в 2 неделы',
      't.weekly':     'Раз в неделю'
    }
    $translateProvider.preferredLanguage 'en'
    return
]

module.run [
  '$cookies'
  '$translate'
  ($cookies, $translate) ->
    preferredLanguage = $cookies.get('preferredLanguage')
    if preferredLanguage
      $translate.use preferredLanguage
    return
]

module.filter 'percentage', [
  '$filter'
  ($filter) ->
    (input, decimals) ->
      return $filter('number')(input * 100, decimals) + '%'
]

module = angular.module 'shiny', [
  'pascalprecht.translate'
  'ngCookies'
  'ngAnimate'
]

module.config [
  '$translateProvider'
  ($translateProvider) ->
    $translateProvider.translations 'en', {
      't.bed': 'bedrooms'
    }
    $translateProvider.translations 'ru', {
      't.bed': 'спальни'
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

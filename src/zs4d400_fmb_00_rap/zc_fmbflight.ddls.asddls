@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_FMBFLIGHT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_FMBFLIGHT
{
  key Uuid,
  Carrid,
  Connid,
  FlightDate,
  AirportFrom,
  CityFrom,
  CountryFrom,
  AirportTo,
  CityTo,
  CountryTo,
  Price,
  @Semantics.currencyCode: true
  CurrencyCode,
  PlaneTypeId,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}

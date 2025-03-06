@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_FMBFLIGHT
  as select from ZFMBFLIGHT
{
  key uuid as Uuid,
  carrid as Carrid,
  connid as Connid,
  flight_date as FlightDate,
  airport_from as AirportFrom,
  city_from as CityFrom,
  country_from as CountryFrom,
  airport_to as AirportTo,
  city_to as CityTo,
  country_to as CountryTo,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency_code as CurrencyCode,
  plane_type_id as PlaneTypeId,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
  
}

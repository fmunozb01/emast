CLASS lhc_zr_fmbflight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR flight
        RESULT result,
      validatecurrencycode FOR VALIDATE ON SAVE
        IMPORTING keys FOR flight~validatecurrencycode,
      validateprice FOR VALIDATE ON SAVE
        IMPORTING keys FOR flight~validateprice.
ENDCLASS.

CLASS lhc_zr_fmbflight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateCurrencyCode.
    READ ENTITIES OF zr_fmbflight IN LOCAL MODE
     ENTITY flight
     FIELDS ( CurrencyCode )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_flights).

    IF lt_flights IS NOT INITIAL.
      SELECT FROM I_Currency
      FIELDS Currency
      FOR ALL ENTRIES IN @lt_flights
      WHERE Currency = @lt_flights-CurrencyCode
      INTO TABLE @DATA(lt_currency).

      LOOP AT lt_flights REFERENCE INTO DATA(lo_flight).
        IF NOT line_exists( lt_currency[ Currency = lo_flight->CurrencyCode ] ).
          APPEND INITIAL LINE TO failed-flight REFERENCE INTO DATA(lo_failed).
          lo_failed->%tky = lo_flight->%tky.

          APPEND INITIAL LINE TO reported-flight REFERENCE INTO DATA(lo_reported).
          lo_reported->%msg = new_message(
              id       = 'ZFMB'
              number   = '102'
              severity = if_abap_behv_message=>severity-error
              v1       = lo_flight->CurrencyCode
          ).
          lo_reported->%tky = lo_flight->%tky.


        ENDIF.
      ENDLOOP.
    ENDIF.


  ENDMETHOD.

  METHOD validatePrice.
    READ ENTITIES OF zr_fmbflight IN LOCAL MODE
      ENTITY flight
      FIELDS ( Price )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_flights).

    LOOP AT lt_flights REFERENCE INTO DATA(lo_flight).
      IF lo_flight->Price <= 0.
        APPEND INITIAL LINE TO failed-flight REFERENCE INTO DATA(lo_failed).
        lo_failed->%tky = lo_flight->%tky.

        APPEND INITIAL LINE TO reported-flight REFERENCE INTO DATA(lo_reported).
        lo_reported->%msg = new_message(
            id       = 'ZFMB'
            number   = '101'
            severity = if_abap_behv_message=>severity-error
        ).
        lo_reported->%tky = lo_flight->%tky.


      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

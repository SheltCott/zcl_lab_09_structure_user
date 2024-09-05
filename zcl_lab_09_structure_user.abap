CLASS zcl_lab_09_structure_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    TYPES:
*       Define structure TY_FLIGHTS
      BEGIN OF ty_flights,
        iduser     TYPE /aif/docu_id,
        aircode    TYPE s_carr_id,
        flightnum  TYPE s_conn_id,
        key        TYPE land1,
        seat       TYPE s_seatsocc,
        flightdate TYPE s_date,
      END OF ty_flights,

*       Define structure TY_AIRLINES
      BEGIN OF ty_airlines,
        carrid    TYPE s_carr_id,
        connid    TYPE s_conn_id,
        countryfr TYPE land1,
        cityfrom  TYPE s_from_cit,
        airpfrom  TYPE s_fromairp,
        countryto TYPE land1,
      END OF ty_airlines,

*       Define nested structure TY_NESTED
      BEGIN OF ty_nested,
        flights  TYPE ty_flights,
        airlines TYPE ty_airlines,
      END OF ty_nested,

*       Define deep structure TY_DEEP
      BEGIN OF ty_deep,
        carrid  TYPE s_carr_id,
        connid  TYPE s_conn_id,
        flights TYPE STANDARD TABLE OF ty_flights WITH EMPTY KEY,
      END OF ty_deep.

    TYPES BEGIN OF ty_include_flights.
    INCLUDE TYPE ty_flights AS flights.
    INCLUDE TYPE ty_airlines AS airlines.
    TYPES END OF ty_include_flights.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_09_structure_user IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: ls_flight    TYPE ty_flights,
          ls_airline   TYPE ty_airlines,
          ls_nested    TYPE ty_nested,
          lt_flights   TYPE STANDARD TABLE OF ty_flights,
          ls_deep      TYPE ty_deep,
          ls_inc_table TYPE ty_include_flights.

*     Add data to TY_FLIGHTS
    ls_flight-iduser = 'U123'.
    ls_flight-aircode = 'LH'.
    ls_flight-flightnum = '400'.
    ls_flight-key = 'DE'.
    ls_flight-seat = '123'.
    ls_flight-flightdate = '20230904'.
    APPEND ls_flight TO lt_flights.

*     Add data to TY_AIRLINES
    ls_airline-carrid = 'LH'.
    ls_airline-connid = '400'.
    ls_airline-countryfr = 'DE'.
    ls_airline-cityfrom = 'Frankfurt'.
    ls_airline-airpfrom = 'FRA'.
    ls_airline-countryto = 'US'.

*     Add data to TY_NESTED
    ls_nested-flights = ls_flight.
    ls_nested-airlines = ls_airline.

    ls_nested = VALUE #(
    flights     = VALUE #( iduser = 'U123'
                           aircode = 'LH'
                           flightnum = '400'
                           key = 'DE'
                           seat = '123'
                           flightdate = '20230904' )
    airlines = VALUE #( carrid = 'LH'
                        connid = '400'
                        countryfr = 'DE'
                        cityfrom = 'Frankfurt'
                        airpfrom = 'FRA'
                        countryto = 'US' )  ).

*     Add data to TY_DEEP
    ls_deep-carrid = 'LH'.
    ls_deep-connid = '400'.
    ls_deep-flights = lt_flights.
*
    ls_deep = VALUE #(
          carrid = 'LH'
          connid = '400'
          flights = VALUE #( ( iduser = 'U123'
                               aircode = 'LH'
                               flightnum = '400'
                               key = 'DE'
                               seat = '123'
                               flightdate = '20230904' ) )
        ).

*     Add data to Include Structure
    ls_inc_table-flights-iduser = 'U123'.
    ls_inc_table-flights-aircode = 'LH'.
    ls_inc_table-flights-flightnum = '400'.
    ls_inc_table-flights-key = 'DE'.
    ls_inc_table-flights-seat = '123'.
    ls_inc_table-flights-flightdate = '20230904'.

    ls_inc_table-airlines-carrid = 'LH'.
    ls_inc_table-airlines-connid = '400'.
    ls_inc_table-airlines-countryfr = 'DE'.
    ls_inc_table-airlines-cityfrom = 'Frankfurt'.
    ls_inc_table-airlines-airpfrom = 'FRA'.
    ls_inc_table-airlines-countryto = 'US'.

*     Output added data
    out->write( data = ls_flight name = 'Flights Structure' ).
    out->write( data = ls_airline name = 'Airline Structure' ).
    out->write( data = ls_nested name = 'Nested Structure' ).
    out->write( data = ls_deep name = 'Deep Structure' ).
    out->write( data = ls_inc_table name = 'Include Structure' ).

*    Delete Nested and Deep Structure
    CLEAR: ls_nested, ls_deep.
  ENDMETHOD.
ENDCLASS.
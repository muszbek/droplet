# Droplet

name: shipment as in "drop" from the air, "let" as in many small ones

logo: a box with a parachute, viewed from an angle below

## purpose:

short term: compare prices of groceries, notify of discounts real time

long term: the to-go platform to find items during shortages

## functionalities:

### seller:
- authenticate with OAuth
- subscribe a store, GM (Google Maps) find place + GM placeId into database (careful, placeId is not entirely constant)
- publish stream events (new discount or availability etc)
-- tagged with type of product, hierarchically (food, meat, chicken, breast)
-- type of event also (more relevant in shortage phase, so introduce later)
- able to monitor clicks and views for each event
- receive notification when an offer is marked as obsolete (introuce later)

### customer
- wall of events ("New Offers") filtered by radius, in order of arrival, paginated (easier, but also less priority)

#### default view
- map with current location
- all active events on map within radius, displayed by type icon of their most recent, updating real time

#### search view
- map current location or specific address
- filter events (tag of type, age, preference newest)
- after filtering, locations are marked with price (and name maybe)
- click on location marker to view offer details
-- display GM details of store
-- display filtered offers in detail (photo, price, availability, etc. whatever the seller uploaded)
-- display other offers of the same store, ordered by age

#### background job
- clicks and views (just appearing on the screen of someone) are streamed, no customer id just aggregated per event
- do we need GDPR legal stuff?
- user identity may be stored in cookies (without registered account) to be able to mark/unmark obsolete offers (introduce later)
- analytics are calculated and displayed on store view about how up-to-date their offers are, how responsively they cancel what is marked as obsolete by users (introduce later)

### events
- events need to have an id so it can be referenced
- publisher publishes event
- publisher cancels event
- publisher sets timer, timer cancels event (default 1 week or so)
- user marks as obsolete event (this is counted)
- user removes obsolete event

## business
- monthly subscription per store via Stripe (because this I know how to do)
- one seller can have multiple stores on multiple timelines
-- treat subscriptions separately as separate products
-- under the same customer, one invoice
- later on it can be adapted to clicks and views

## tech
- Apache Kafka for streaming
-- offer events produced by seller users
-- click/view events produced by customer users (anyone who opens the app), implicit, background job
- Kafka ksqlDB for filtering offer events
- Google OAuth for authenticating seller users
- couchDB for storing seller users and what-not (any database is fine but I want to try this one, + clustering)
- Google Maps API for registering stores by seller users
- Google Maps JavaScript API for displaying map and location markers
- all code in Elixir Phoenix, Liveview, native JavaScript
- TLS with LetsEncrypt + CertBot
- postfix if need to send emails (maybe later)
- HAproxy maybe needed, maybe not
- Docker + Kubernetes deployment as usual

## architecture
- customer app as default
- seller app separately because they only connect via Kafka
- Kafka server
- ksqlDB server
- couchDB server
- postfix server
- haproxy server (maybe)
- everything clustered (postfix + haproxy not so much for load, just redundancy)

## data type
- seller users - primary key email (multiple login modes that don't know about each other)
-- access rights: admin (me), owner (manage subscription and publishers), publisher
-- publishers always belong to an owner
-- publishers will be implemented later
- stores - primary key integer uid
-- many store can belongs to one owner
-- publishers need to access store reference (via owner reference)

## timeline
1. basic architecture
- couchDB
- OAuth
- seller Phoenix server registers and authenticates sellers
- Google Maps API
- seller Phoenix server seller registers store
- Kafka
- seller Phoenix server seller publishes offers
- seller Phoenix server seller cancels offers

2. basic client
- Google Maps JavaScript API
- Kafka ksqlDB
- customer Phoenix server displays map, search own location
- customer Phoenix server displays offers on map
- customer Phoenix server displays offers on event wall

3. filtering offers
- customer Phoenix server filters offers by tag, age
- customer Phoenix server displays store details
- customer Phoenix server displays offers related to store with their details

4. set up Stripe for Phoenix server seller payments

5. refine architecture
- apply everything in Docker containers
- set up TLS
- set up HAproxy if needed
- apply Kubernetes cluster

======== MVP status reached ==========

6. refine front-end
- apply icons to Google Map view
- other display improvements

7. set up client monitoring
- attach Kafka producer to customer view
- stream clicks and views in the background
- check if this is legal
- seller Phoenix server seller can view analytics of clicks and views per store per event

8. adapt front-end to mobile platforms

======== prototype status reached =========

9. set up user marking offers obsolete - this is tricky
- should users see on offer how many marked obsolete?
- should sellers be notified every time?
- should users be able to cancel their mark? (if yes, retain user identity by cookies, no registering)

10. analytics about seller responsiveness
- gather analytics
- display analytics
- this is a broad subject of data science and user interaction, deal with it later

11. highlight cheapest of item
- directions to
- directions to any other store

12. implement publisher access right to seller API

## Kafka
topic layout:
*stores/v1/offers/fr/lat&long*

** Kafka is abandoned, it's not the right tool because I cannot recover past events in the client, a regular database does it and I don't really need real time processing **

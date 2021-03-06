Changelog
=========

### 0.7.0
  * (ihoka) Ruby 1.9.3 compatibility. 1.8.x no longer supported.

### 0.6.3
  * (ihoka) Running config.yml through ERB

### 0.6.2
  * (ihoka) renamed gem to ihoka-friendly

### 0.6.1
  * (ihoka) upgraded to Jeweler 1.5
  * (ihoka) updated gem dependencies

### 0.5
  
  * (jamesgolick) Add offline index building.

### 0.4.4

  * (jamesgolick) Make it possible to query with order, but no conditions.
  * (jamesgolick) Add change tracking. This is mostly to facilitate arbitrary caches.

### 0.4.2

  * (nullstyle) convert UUID to SQL::Blob so that Sequel can properly escape it in databases that don't treat binary strings like regular strings.

### 0.4.1

  * (jamesgolick) Fix for ruby 1.9.1.

### 0.4.0

  * (jamesgolick) Add scope chaining. See the README and the docs for Friendly::Scope.
  * (jamesgolick) Add has_many association.
  * (jamesgolick) Add ad-hoc scopes. See the docs for Document.scope.
  * (jamesgolick) Add named_scope functionality. See the docs for Document.named_scope.
  * (jeffrafter + jamesgolick) DDL generation now supports custom types. Previously, it would only work with types that Sequel already supported. Now, if you want to register a custom type, use Friendly::Attribute.register_type(klass, sql_type, &conversion_method).


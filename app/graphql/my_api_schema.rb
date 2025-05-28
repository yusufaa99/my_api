# frozen_string_literal: true

class MyApiSchema < GraphQL::Schema
  # Debugging: Print a message when the schema is loaded
  puts "Loading MyApiSchema..."

  # Specify the types for mutation and query
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Use Dataloader for batch-loading queries
  use GraphQL::Dataloader

  # Override the error handler for type errors (e.g., invalid null values or type mismatches)
  def self.type_error(err, context)
    # Handle errors such as invalid null errors or type mismatches
    # You can add custom logging or reporting here if needed
    super
  end

  # Handle union and interface resolution (useful when dealing with polymorphic types)
  def self.resolve_type(abstract_type, obj, ctx)
    # TODO: Implement this method if you plan to use Union types or Interfaces
    # Example:
    # case obj
    # when SomeModel then Types::SomeModelType
    # else raise(GraphQL::RequiredImplementationMissingError)
    # end
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Limit the size of incoming queries to avoid performance hits from excessively large queries
  max_query_string_tokens(5000)

  # Set the maximum number of validation errors before the schema stops processing
  validate_max_errors(100)

  # Relay-style Object Identification: Convert an object to a unique ID and back

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # Example: Convert object to a global ID string (you can use Rails' GlobalID here)
    object.to_gid_param
  end

  # Given a string UUID, find the object by its ID
  def self.object_from_id(global_id, query_ctx)
    # Example: Lookup the object from the global ID
    GlobalID.find(global_id)
  end
end
class BillApiError < StandardError
  
end

# Raise if model not respond to persistense models
class NonPersistenseModel < BillApiError 
  
end

class DeserializationError < BillApiError
 
end

class BillNonSpecified < BillApiError
  
end
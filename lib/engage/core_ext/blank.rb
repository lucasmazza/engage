# https://github.com/rails/rails/blob/87ae85d5360ac8965f24/activesupport/lib/active_support/core_ext/object/blank.rb
class Object #:nodoc:
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
  def present?
    !blank?
  end
  def presence
    self if present?
  end
end

class NilClass #:nodoc:
  def blank?
    true
  end
end

class FalseClass #:nodoc:
  def blank?
    true
  end
end

class TrueClass #:nodoc:
  def blank?
    false
  end
end

class Array #:nodoc:
  alias_method :blank?, :empty?
end

class Hash #:nodoc:
  alias_method :blank?, :empty?
end

class String #:nodoc:
  def blank?
    self !~ /\S/
  end
end

class Numeric #:nodoc:
  def blank?
    false
  end
end
# Create with indiferent access to ruby version. This is native on rails and
# allow indiferent access from hash for string or symbols
#
# More info here:
# https://api.rubyonrails.org/v5.2/classes/ActiveSupport/HashWithIndifferentAccess.html
#
# This is a small implementation and convert all strings to symbols only,
# the name may be misleading but it was used to be easily ported to a rails
# application without changing the code except for removing this file.
#

module Extensions
  module Hash
    module WithIndeferentAccess
      def with_indiferent_access
        ::Hash[self.map{|k,v|[k.to_sym,v]}]
      end
    end
  end
end

Hash.include Extensions::Hash::WithIndeferentAccess

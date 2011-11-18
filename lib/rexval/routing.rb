ActionDispatch::Routing::Mapper.send :include, Rexval::RegexpFinder
ActionDispatch::Routing::Mapper.send :include, Rexval::Routing::RegexpFinder
ActionDispatch::Routing::Mapper.send :include, Rexval::Routing::Constraints

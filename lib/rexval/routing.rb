ActionDispatch::Routing::Mapper.send :include, Rexval::RegexpFinder
ActionDispatch::Routing::Mapper.send :include, Rexval::Routing::RegexpFinder
# Below commented out while bugs are fixed
# ActionDispatch::Routing::Mapper.send :include, Rexval::Routing::Constraints

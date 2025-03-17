import importlib.util

module_name = "DB.DatabaseConnection"
module_path = "./DB/DatabaseConnection.py"

spec = importlib.util.spec_from_file_location(module_name, module_path)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

# Now access SQLQuery
SQLQuery = module.SQLQuery

# --------------------------------------------------
# Install project dependencies from YAML into renv
# --------------------------------------------------

# 1. Ensure renv is available
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}
library(renv)

# 2. Initialize renv if not already done
if (!file.exists("renv.lock")) {
  renv::init(bare = TRUE)
}

# 3. Ensure yaml is available (outside renv bootstrap issue)
if (!requireNamespace("yaml", quietly = TRUE)) {
  renv::install("yaml")
}
library(yaml)

# 4. Read YAML configuration
cfg <- yaml::read_yaml("dependencies.yml")

# 5. Extract and clean package list
pkgs <- unique(unlist(cfg$packages, use.names = FALSE))

# 6. Install packages into renv
renv::install(pkgs)

# 7. Snapshot environment
renv::snapshot(prompt = FALSE)

# 8. Cleanup
rm(cfg, pkgs)



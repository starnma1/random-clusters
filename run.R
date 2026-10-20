{r, eval = FALSE}

# Load the library for parsing
library(argparse)

# Define the paths to the data
parser <- ArgumentParser()
parser$add_argument("--output_dir")
parser$add_argument("--data.h5ad", dest = "data_path")
args <- parser$parse_known_args()[[1]]

raw_data <- zellkonverter::readH5AD(args$data_path)
cells <- colnames(raw_data)

# Set seed for reproducibility
set.seed(10)

# Randomly sample
clusters <- 10
labels <- sample(1:clusters, length(cells), replace = TRUE)

# Save the output
output <- data.frame(cell_id = cells, louvain = labels, leiden = labels)
write.csv(output, file.path(args$output_dir, "datasets-r.clusters.tsv"), sep = "\t")

# So that the yaml doesnt crash (see AI decleration)
writeLines("cell_id\tPC1", file.path(args$output_dir, "datasets-r.pca.tsv"))
writeLines("{}", file.path(args$output_dir, "datasets-r.timings.json"))
writeLines("{}", file.path(args$output_dir, "datasets-r.clustering_info.json"))
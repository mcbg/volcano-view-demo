library(data.table)
library(ggplot2)
library(volcano.view)
library(fst)
library(mgMisc)

# load ------------------------------------------------------------------

# bypass dataset
ana = readRDS('bypass-dataset.rds')

# load, enrichment  -------------------------------------------------------------------

enrichment = readRDS('enrichment.rds') # results of set enrichment analysis
genelist = readRDS('sets.rds') # elements of each set, linking to the id variable

# dashboard ---------------------------------------------------------------

vw.config = ana |>
  volcano.view(x='log2 fold change', y='negative log10 p-value', id='id') +
  module.drill('EntrezGeneSymbol', 'TargetFullName') +
  module.title('Surgery vs nonsurgery, 36 months') +
  module.drillplots('Average') +
  module.url('UniProt', 'NCBI') +
  module.genelist(
    collection = genelist,
    enrichment = enrichment,
    drill=c('category', 'name')
  ) +
  module.about(
    c('Description', 'Arms', 'Dataset source', 'Assay'),
    c(
      'Comparison of Roux-en-Y gastric bypass surgery vs. nonsurgery',
      'Surgery (n=137)\n\nNonsurgery (n=66)',
      '*Yousri NA, Engelke R, Sarwath H, et al. Proteome-wide associations with short- and long-term weight loss and regain after Roux-en-Y gastric bypass surgery. Obesity (Silver Spring). 2022; 30: 129–141. doi:10.1002/oby.23303*',
      'SomaScan'
      )
  )

# export ------------------------------------------------------------------

save.website(x = vw.config, 'demo')

# copy static plots ------------------------------------------------------------------

dir.create('demo/output')
list.files('output', full.names = T) |>
  file.copy('demo/output')

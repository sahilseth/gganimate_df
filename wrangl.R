
# source('~/Dropbox2/Dropbox/public/gitlab_gganimate_heat/wrangl.R')

wd = "~/Dropbox/public/gitlab_gganimate_heat"
setwd(wd)

if(!require(pacman)) install.packages("pacman")
library(pacman)

p_load_gh("dgrtwo/gganimate")

# initialize a matrix
init_df = expand.grid(row = 1:3, col = 1:3)

rows <- 10
cols <- 10

mat = matrix(0, nrow = rows, ncol = cols)

#i=2;j=2

library(ggplot2)
theme_set(theme_minimal())

library(reshape2)
library(dplyr)

tmp <- lapply(1:(rows-2), function(i){
  #message("> working on, ", i)
  tmp = lapply(1:(cols-2), function(j){
    
    message("> working on, ", i, " ", j)
    # current df
    cur_df = init_df
    cur_df$row = cur_df$row + (i - 1)
    cur_df$col = cur_df$col + (j - 1)
    # assign values 1
    mat[as.matrix(cur_df)] <- 1
    print(sum(mat[as.matrix(cur_df)]))

    data.frame(melt(mat, varnames = c("row", "col")), coords = paste0(i, " ", j))
    
  })    
  bind_rows(tmp)
})

df = bind_rows(tmp)


message("> annimating...")

library(gganimate)
p = ggplot(df, aes(col, row, fill = value, frame = coords)) +
  geom_raster() + ylim(c(cols, 1)) + xlim(c(1, rows))

#gg_animate(p)
gg_animate(p, "output.gif", interval = .2)






# END
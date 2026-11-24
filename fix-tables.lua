function Table(tbl)
  local num_cols = #tbl.colspecs
  for i = 1, num_cols do
    tbl.colspecs[i][2] = 1.0 / num_cols
  end
  return tbl
end


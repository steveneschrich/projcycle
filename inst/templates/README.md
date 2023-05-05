# {{Project}}

This is the R project for {{PI}}/{{Project}}. It is a quarto website. 

## Working
Create quarto reports in `reports` based on data from `data` directory.

- Consider using `order: N` in the quarto reports to arrange the output in the web site.

## Building

- Checkout the source: 
```
git clone URL
```

- To initialize the data directory:
```
projcycle::build_data()
```

- To render reports:
```
make render; make publish
```

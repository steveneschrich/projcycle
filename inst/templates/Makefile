# REMOTEDIR is the remote directory on the server
SSH_HOSTNAME={{ssh_hostname}}
REMOTEDIR={{shiny_remotedir}}

# PUBDIR is the local website output directory (output-dir option in _quarto.yml)
PUBDIR = $(shell grep output-dir _quarto.yml | sed -e's/^.*:[ ]*//' | sed -e's/[ ]*$$//')
# DESTDIR is the main directory on the remote server (the title of the index.qmd file).
DESTDIR = $(shell grep title index.qmd | sed -e's/^.*:[ ]*//' | sed -e's/"//g' | sed -e's/[ ]*$$//')


all:
	@echo "make render or make publish (like quarto)"

init-site:
	ssh $(SSH_HOSTNAME) mkdir -p $(REMOTEDIR)/$(DESTDIR)

test:
	@echo rsync -avz $(PUBDIR)/ $(REMOTEDIR)/$(DESTDIR)/

render:
	quarto render

publish:
	rsync -avz $(PUBDIR)/ $(SSH_HOSTNAME):$(REMOTEDIR)/$(DESTDIR)

.PHONY: data-raw
data-raw:
	Rscript -e 'projcycle::build_data()'


#USE BLAST BINARIES FROM UMMIDOCK REPO 
FROM ummidock/blast_binaries:2.6.0-binaries 
WORKDIR /NGStools/
RUN apt-get update

RUN apt-get update && apt-get -y install \
	bc \
	bzip2 \
	gcc \
	git \
	gzip \
	make \
	wget  \
	unzip \
	python \
	parallel \
	zlib1g-dev

#get bowtie
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.9/bowtie2-2.2.9-linux-x86_64.zip && unzip bowtie2-2.2.9-linux-x86_64.zip
ENV PATH="/NGStools/bowtie2-2.2.9:$PATH"

RUN wget https://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2
RUN mkdir samtools && tar jxf samtools-0.1.19.tar.bz2 -C samtools --strip-components=1
WORKDIR /NGStools/samtools/
RUN ./configure --without-curses --disable-bz2 --disable-lzma
RUN make
ENV PATH="/NGStools/samtools:$PATH"

WORKDIR /NGStools/
RUN rm -rf samtools-0.1.19.tar.bz2 

RUN pip2 install --upgrade numpy PyYaml lxml biopython

RUN git clone https://github.com/phe-bioinformatics/emm-typing-tool
ENV PATH="/NGStools/emm-typing-tool:$PATH"

RUN emm_typing.py -h

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <time.h>

void WriteOpenMPProfile(long* BBCounters, long array_size) 
{
	char outstring[150];
	char hostname[100];
	int pid = getpid();
	gethostname(hostname,99);
	sprintf(outstring,"%s.%d.bbfout",hostname,pid);
	printf("hello world  %s\n",outstring);
	FILE *fp = fopen(outstring,"w");
	if(fp==NULL) { printf("open file wrong\n"); return; }
	//int array_size = sizeof(BBCounters)/sizeof(BBCounters[0]);
	for(int i=0;i<array_size;++i)
	{
		fprintf(fp,"%ld\t",BBCounters[i]);    
	}
	fclose(fp);
	return;
}

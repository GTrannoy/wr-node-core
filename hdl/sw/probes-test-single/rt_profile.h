/**
 * This is the real-time application to the Master
 */

#ifndef __RT_PROFILE_H
#define __RT_PROFILE_H


#define mt_probe_create( id, name ) \
{ \
asm volatile(	"\n" \
		".section .mt_probes, \"a\"\n" \
	        ".word 0\n"\
	        ".word " #id "\n"\
	        ".ascii " #name "\n"\
	        ".byte 0\n"\
		".section .text\n" ); \
}


#define mt_probe_trigger( id) \
{ \
asm volatile(	"\n" \
		".section .text\n" \
		"__probe_trigger" #id ":\n" \
		".section .mt_probes\n" \
	        ".word 1\n"\
	        ".word " #id "\n"\
	        ".word __probe_trigger" #id "\n"\
		".section .text\n");\
}

#define mt_profile_start(id) \
{ \
asm volatile(	"\n" \
		".section .text\n" \
		"__profile_start" #id ":\n" \
		".section .mt_probes\n" \
	        ".word 2\n"\
	        ".word " #id "\n"\
	        ".word __profile_start" #id "\n"\
		".section .text\n");\
}

#define mt_profile_stop( id) \
{ \
asm volatile(	"\n" \
		".section .text\n" \
		"__profile_stop" #id ":\n" \
		".section .mt_probes\n" \
	        ".word 3\n"\
	        ".word " #id "\n"\
	        ".word __profile_stop" #id "\n"\
		".section .text\n");\
}

#endif

/*
 * Copyright notice
 *
 * (c) 2010 Robert Eaglestone.  All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
package c64.storage.formats
/*
   D16 format

   Based on formats used by Ruud Baltissen  (http://www.baltissen.org/newhtm/1541ide8.htm).
   This version has 255 tracks, with 248 sectors per track, for about 15.8 megabytes.

   Header             = 18,0
   BAM                = 18,1-32
   Directory          = 18,33-255
   DOS Type           = 82    // version D16 format
   DOS Version/Format = '2R'  // DOS-version and format
   Disk Name          = 16 bytes
   $A0

   BAM is 31 bytes per track.
 */
{
	import c64.storage.CMD;
	
	public class D16 extends c64.storage.CMD implements Storable
	{
		public function D16(fn:String=null)
		{
			super(fn);
			
			EXTENSION 					 = 'D16';
			DOS_VERSION                  = 'R';
			DOS_TYPE                     = '2R';
			
			var zones:Array   = [[255,248]];
			var header:int    = 18;
			var dir:int       = 18;
			var bam:int       = 18;
			var dirSector:int = 33;
			var hdrNameOffset:int = 0x04;
			var bamOffset:int = 0x06;
			var bamInterleave:int = 1;
			var bamHasSectorCount:Boolean = false; // gets us 8 more sectors per track
			
			this.configure( zones, 
							false, 
							false, 
							header, 
							dirSector, 
							hdrNameOffset, 
							bamOffset, 
							bamInterleave, 
							true,
							1, 1,
							false,
							bamHasSectorCount );		
		}	
	}
}			
/* 		    TRACKS           			 = 254;
   TOTAL_SECTORS    			 = TRACKS * 256;

   HEADER_TRACK     			 = 18;
   HEADER_SECTOR    			 = 0;
   HEADER_DISK_NAME_BYTE_OFFSET = 0x90;

   BAM_TRACK        			= 0; // amazing what software can address.
   BAM_SECTOR_TO_TRACK_MAPPING = [
   [ 224, 0, 7 ],       // yes, I know there's no *actual* Track 0.  I need this to balance it all out.
   [ 225, 8, 15 ],
   [ 226, 16, 23 ],
   [ 227, 24, 31 ],
   [ 228, 32, 39 ],
   [ 229, 40, 47 ],
   [ 230, 48, 55 ],
   [ 231, 56, 63 ],
   [ 232, 64, 71 ],
   [ 233, 72, 79 ],
   [ 234, 80, 87 ],
   [ 235, 88, 95 ],
   [ 236, 96, 103 ],
   [ 237, 104, 111 ],
   [ 238, 112, 119 ],
   [ 239, 120, 127 ],
   [ 240, 128, 135 ],
   [ 241, 136, 143 ],
   [ 242, 144, 151 ],
   [ 243, 152, 159 ],
   [ 244, 160, 167 ],
   [ 245, 168, 175 ],
   [ 246, 176, 183 ],
   [ 247, 184, 191 ],
   [ 248, 192, 199 ],
   [ 249, 200, 207 ],
   [ 250, 208, 215 ],
   [ 251, 216, 223 ],
   [ 252, 224, 231 ],
   [ 253, 232, 239 ],
   [ 254, 240, 247 ],
   [ 255, 248, 255 ]  // nb Track 255 is interdicted
   ];

   BAM_OFFSET      		    = 0x00;
   BAM_BYTES_PER_TRACK 		= 32;
   BAM_SECTOR_BYTES_PER_TRACK  = 32;

   DIRECTORY_TRACK  			= 18;
   DIRECTORY_SECTOR 			= 1;
   DIRECTORY_INTERLEAVE 		= 3;

   SECTORS_IN_TRACK =
   [
   0,                                                                   // "0"
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256, 256,256,256,256,256,256,256,256,
   256,256,256,256,256,256,256,256   //  <-- nb Track 255 is interdicted
   ];

   TRACK_OFFSET =
   [
   0x0,                                                                                       // "track 0"
   0x0,
   256,512,768,1024,1280,1536,1792,2048,2304,2560,2816,3072,3328,3584,3840,4096,
   4352,4608,4864,5120,5376,5632,5888,6144,6400,6656,6912,7168,7424,7680,7936,8192,
   8448,8704,8960,9216,9472,9728,9984,10240,10496,10752,11008,11264,11520,11776,12032,
   12288,12544,12800,13056,13312,13568,13824,14080,14336,14592,14848,15104,15360,15616,
   15872,16128,16384,16640,16896,17152,17408,17664,17920,18176,18432,18688,18944,19200,
   19456,19712,19968,20224,20480,20736,20992,21248,21504,21760,22016,22272,22528,22784,
   23040,23296,23552,23808,24064,24320,24576,24832,25088,25344,25600,25856,26112,26368,
   26624,26880,27136,27392,27648,27904,28160,28416,28672,28928,29184,29440,29696,29952,
   30208,30464,30720,30976,31232,31488,31744,32000,32256,32512,32768,33024,33280,33536,
   33792,34048,34304,34560,34816,35072,35328,35584,35840,36096,36352,36608,36864,37120,
   37376,37632,37888,38144,38400,38656,38912,39168,39424,39680,39936,40192,40448,40704,
   40960,41216,41472,41728,41984,42240,42496,42752,43008,43264,43520,43776,44032,44288,
   44544,44800,45056,45312,45568,45824,46080,46336,46592,46848,47104,47360,47616,47872,
   48128,48384,48640,48896,49152,49408,49664,49920,50176,50432,50688,50944,51200,51456,
   51712,51968,52224,52480,52736,52992,53248,53504,53760,54016,54272,54528,54784,55040,
   55296,55552,55808,56064,56320,56576,56832,57088,57344,57600,57856,58112,58368,58624,
   58880,59136,59392,59648,59904,60160,60416,60672,60928,61184,61440,61696,61952,62208,
   62464,62720,62976,63232,63488,63744,64000,64256,64512,64768,65024,65280,65536   //  <-- nb Track 255 is interdicted
   ];

   SECTOR_OFFSET = TRACK_OFFSET;

   TRACK_WRITE_ORDER =
   [
   1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
   //18,
   19,20,21,22,23,24,25,26,27,28,29,30,31,
   32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,
   62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,
   91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,
   115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,
   137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,
   159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,
   181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,
   203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
   225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,
   247,248,249,250,251,252,253,254 // ,255 <-- nb Track 255 is interdicted
   ];
 }		 */



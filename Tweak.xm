
#include <sys/utsname.h>

%hook CydiaWebViewController

+ (NSURLRequest *) requestWithHeaders:(NSURLRequest *)request {
	
	id copy = %orig(request);
    NSURL *url([copy URL]);
	NSString *href([url absoluteString]);
    NSString *host([url host]);

    struct utsname u = { 0 };

    uname(&u);

    NSString *deviceModel = [NSString stringWithUTF8String:u.machine];

    NSString *fakeUserAgent = nil;
    NSString *fakeDeviceModel = nil;

    if ([deviceModel rangeOfString:@"iPhone"].location != NSNotFound)
    {
    	fakeDeviceModel = @"iPhone9,3";
    	fakeUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32";
    } else if ([deviceModel rangeOfString:@"iPad"].location != NSNotFound) {
    	fakeDeviceModel = @"iPad5,3";
    	fakeUserAgent = @"Mozilla/5.0 (iPad; CPU OS 10_2 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32";
    } else if ([deviceModel rangeOfString:@"iPad"].location != NSNotFound) {
    	fakeDeviceModel = @"iPod7,1";
    	fakeUserAgent = @"Mozilla/5.0 (iPod touch; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32";
    }

	if ([href hasPrefix:@"https://cydia.saurik.com"] && !fakeUserAgent && !fakeDeviceModel){
		
		[copy setValue:fakeUserAgent forHTTPHeaderField:@"User-Agent"];
	
		[copy setValue:fakeDeviceModel forHTTPHeaderField:@"X-Machine"];

	}
	
	return copy;
}

%end
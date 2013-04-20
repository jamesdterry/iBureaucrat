iBureaucrat
==========

A forms library for iOS. 

##Status?

* Still alpha, but stable API
* iPad not yet supported (though this will be very simple to add). 


![Form](http://jasperblues.github.com/iBureaucrat/form.png)
![Edit](http://jasperblues.github.com/iBureaucrat/edit.png)

#Why?

Nobody likes filling out forms. Or making them. iBureaucrat lets you rapidly create forms for you iOS apps - so you 
can get back to the fun stuff. 

Using tableviews is the defacto standard way to layout forms for iOS, and they look great. But for every project there's a
lot of boiler-plate code to set up - different kinds of table-view cells, custom input views, automatically scrolling
to accommodate the keyboard/inputview, etc. . It ends up being the same old plumbing code over and over. 

There are a few fantastic forms libraries for iOS. This one attempts to be: 

* Simple and fast to set up forms. 
* Easy to customize by defining new types, look-and-feel, etc. 

#Usage

###Create a view controller

* Create a view controller
* Add a BCFormView to the view controller's view. 
* Give the BCFormView a form, as follows:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    FundsTransferView* view = (FundsTransferView*) self.view;

    _form = [BCForm new]; //Using default colors.
    _form.delegate = self;
    [_form addSection:[self createTransportDetailsSection]];
    [_form addSection:[self createDetailsSection]];
    
    view.formView.form = _form;
}

- (BCFormSection*)createTransportDetailsSection
{
    BCFormSection* transportDetailsSection = [BCFormSection sectionWithTitle:@"Transport Details"];
    _sendBy = [BCPickerField fieldWithLabel:@"Send by"];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Horse" traits:@"grain tax"]];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Scoundrel" traits:@"reliable"]];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Ship" traits:@"not good over-land"]];

    _notes = [BCTextField fieldWithLabel:@"Notes"];
    [transportDetailsSection addFields:@[_sendBy, _notes]];
    return transportDetailsSection;
}

```

###Add Delegate methods if you like:

```objective-c
#pragma mark <BCFormDelegate>

- (void)didSelectDone
{
    NSLog(@"Delegate call for done. Field: %@", [_sendBy value]);
}

- (void)didSelectPreviousField
{
    NSLog(@"Delegate call for previous");
}

- (void)didSelectNextField
{
    NSLog(@"Delegate call for next");
}
```

#Creating your own types

* There's an <a href="http://jasperblues.github.io/iBureaucrat/api/Classes/BCAbstractField.html">abstract base-class designed to be extended</a>. 


#Installation: 

* iBureaucrat is availble via CocoaPods (recommended)
* Otherwise, copy the source files to your project directory. Add the QuartzCore and CoreGraphics frameworks. 

# Authors

* <a href="http://ph.linkedin.com/pub/jasper-blues/8/163/778">Jasper Blues</a> - <a href="mailto:jasper@appsquick.ly?Subject=Typhoon">jasper@appsquick.ly</a>
         
### With contributions from: 

* ___Your name here!!!!!!!___ 

Thanks!!!


# LICENSE

Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/

© 2012 - 2013 Jasper Blues and contributors.

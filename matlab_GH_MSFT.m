%Rohan Joshi
%Xignite Demo
%xGlobalHistorical call with MSFT between 8/22/2013 & 8/21/2014
%User must have parse_json.m and urlread2.m in their environment


%Insert token below
user_token = '';

x_GH = 'http://www.xignite.com/xGlobalHistorical.json/GetGlobalHistoricalQuotesRange?IdentifierType=Symbol&Identifier=MSFT&AdjustmentMethod=SplitAndProportionalCashDividend&StartDate=8/22/2013&EndDate=8/21/2014&_token=';
x_URL = strcat(x_GH, user_token);

%Reads the URL and Parses the JSON into a 1x1 Struct
x_results = parse_json(urlread2(x_URL));

%Grabs the GlobalQuotes vector (1x252)
%Since Xignite returns the most recent quote,, using fliplr(), we reverse
% vector
temp = fliplr(x_results.GlobalQuotes); % <1x252 cell>

%Initialize two 252x1 vectors
y_vec = zeros (252,1);
x_vec = zeros (252,1);

%Loop through the GlobalQuotes(temp) vector picking up the LastClose price of
%each day and filling only those prices into our price vector
for i = 1:252
    y_vec(i,1) = temp{1,i}.LastClose;
end

%Similarly, loop through the GlobalQuotes(temp) vector converting the date
%string to a number which represents the serial date, a whole and 
%fractional number of days from a fixed, preset date (January 0, 0000)
%Fills the date vector with those numbers
for i = 1:252
    x_vec(i,1) = datenum(temp{1,i}.Date);
end

%Plots price history
plot(x_vec, y_vec)
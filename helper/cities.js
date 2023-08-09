// Json data in the internet
// Note: this code works in the console tab of browser
var oldCitiesId = [];
var newCitiesId = [];
var citiesName = [];
var cities = {};
var city = {};

const api = "https://shopee.vn/api/v4/location/get_child_division_list"; 
fetch(api)
    .then(function (response) {
        return response.json();
    })
    .then(function (response) {
        cities = response.data.divisions;
        console.log(cities);
        for (var i = 1; i <= cities.length; i++) {
            city = cities[i-1];
            oldCitiesId.push(city.id);
            newCitiesId.push(i);
            citiesName.push(city.division_name);
            if (i == cities.length) {
                console.log(newCitiesId);
                console.log(citiesName);
                console.log(oldCitiesId);
            }
        };
    });



// Results of above code, and I copy it to here for use laster
newCitiesId = [
    1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
   13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
   25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
   37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
   49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
   61, 62, 63
 ];
 citiesName = [
    'An Giang',        'Bà Rịa - Vũng Tàu', 'Bình Dương',
    'Bình Phước',      'Bình Thuận',        'Bình Định',
    'Bạc Liêu',        'Bắc Giang',         'Bắc Kạn',
    'Bắc Ninh',        'Bến Tre',           'Cao Bằng',
    'Cà Mau',          'Cần Thơ',           'Gia Lai',
    'Hà Giang',        'Hà Nam',            'Hà Nội',
    'Hà Tĩnh',         'Hòa Bình',          'Hưng Yên',
    'Hải Dương',       'Hải Phòng',         'Hậu Giang',
    'Khánh Hòa',       'Kiên Giang',        'Kon Tum',
    'Lai Châu',        'Long An',           'Lào Cai',
    'Lâm Đồng',        'Lạng Sơn',          'Nam Định',
    'Nghệ An',         'Ninh Bình',         'Ninh Thuận',
    'Phú Thọ',         'Phú Yên',           'Quảng Bình',
    'Quảng Nam',       'Quảng Ngãi',        'Quảng Ninh',
    'Quảng Trị',       'Sóc Trăng',         'Sơn La',
    'TP. Hồ Chí Minh', 'Thanh Hóa',         'Thái Bình',
    'Thái Nguyên',     'Thừa Thiên Huế',    'Tiền Giang',
    'Trà Vinh',        'Tuyên Quang',       'Tây Ninh',
    'Vĩnh Long',       'Vĩnh Phúc',         'Yên Bái',
    'Điện Biên',       'Đà Nẵng',           'Đắk Lắk',
    'Đắk Nông',        'Đồng Nai',          'Đồng Tháp'
  ];
  oldCitiesId = [
    106169285912657, 106729332900600, 106827152100267,
    106060129593623, 106298624926872, 106839326580859,
    106324687379866, 106496387271509, 106294400662775,
    106473645690021, 106251344671261, 106377439646808,
    106510797402080, 106505036813861, 106513736136903,
    106772796743870, 106952364122626, 106514668070400,
    106713032521530, 106721735558041, 106397111595669,
    106749847251801, 106538828868720, 106839889046657,
    106021788199310, 106205304363112, 106326660481341,
    106280768392335, 106189107499186, 106905215364541,
    106533655472981, 106226493272839, 106293839628868,
    106136307501534, 106930207642849, 106340306969478,
    106771346813210, 106356824377630, 106498018287602,
    106586950856918, 106654324620216, 106275647430979,
    106097269895815, 106733365449835, 106317191241340,
    106008781098622, 106491831005420, 106331484203793,
    106258737793454, 106680184190828, 106267580774335,
    106060721022731, 106901056401826, 106952941014511,
    106538595380528, 106856398884170, 106363273974851,
    106841711796343, 106571472417943, 106527697400008,
    106740938589706, 106629637219088, 106083162282665
  ];

// Generate to get a mySQL statement
var sql = "insert into `cities` (`name`) values\n";
citiesName.forEach(function(cityName) {
    sql += `(\"${cityName}\"),\n`;
})
sql = sql.substring(0, sql.length-2) + ";";
// console.log(sql);



// Export data to use later
module.exports = {
    newCitiesId: newCitiesId,
    citiesName: citiesName,
    oldCitiesId: oldCitiesId
}
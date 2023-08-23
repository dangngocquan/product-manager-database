const data = require('../json/categories.json');

const categories = data.categories;

const categoriesSQL = [];
var tempId = 1;
categories.forEach((category) => {
    solve(category, 1, 0);
})

var sql = "INSERT INTO categories (name, image, level, parent_category_id) VALUES \n";
sql += (categoriesSQL.map((category) => {
    return `(\'${category.name}\', \'${category.image}\', ${category.level}, ${category.parentCategoryId})`
})).join(", \n");
console.log(sql);

function solve(category, level, parentCategoryId) {
    category.level = level;
    category.parentCategoryId = parentCategoryId;
    category.id = tempId;
    category.image = 'default-category-image.png';
    tempId++;
    categoriesSQL.push(category);
    var children = category.children;
    children.forEach((child) => {
        solve(child, level+1, category.id);
    })
    delete category.children;
}


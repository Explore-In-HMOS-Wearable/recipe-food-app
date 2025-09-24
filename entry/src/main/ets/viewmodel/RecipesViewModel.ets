import Recipe from '../model/Recipe';

export const recipesList: Array<Recipe> = [
  {
    id: '1',
    name: 'Lentil Soup',
    imageSource: 'img2.jpg',
    description: 'A staple of Turkish cuisine, lentil soup is prepared with red lentils, carrots, potatoes, and onions. It is served with a topping of butter infused with mint and red pepper flakes. Nutritious and soothing for the stomach.',
    isFavorite: false
  },
  {
    id: '2',
    name: 'Rice Pilaf',
    imageSource: 'img3.jpg',
    description: 'Classic buttered rice pilaf with perfectly separated grains. Made with baldo rice and enriched with toasted vermicelli. A perfect side dish for meat, or delicious enough on its own.',
    isFavorite: false
  },
  {
    id: '3',
    name: 'Pasta',
    imageSource: 'img1.jpg',
    description: 'Italian-style pasta with tomato sauce. Cooked with sautéed garlic, olive oil, and grated tomatoes, then topped with fresh basil and parmesan cheese. A quick, easy, and filling meal.',
    isFavorite: false
  },
  {
    id: '4',
    name: 'Chocolate Pudding',
    imageSource: 'img4.jpeg',
    description: 'A rich and creamy chocolate-flavored milk dessert. Made with cocoa, milk, and starch, and can be decorated with banana slices and biscuits once cooled. A childhood favorite and a secret indulgence for adults.',
    isFavorite: false
  }
];

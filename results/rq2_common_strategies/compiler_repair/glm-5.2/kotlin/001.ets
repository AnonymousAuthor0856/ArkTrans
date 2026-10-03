// 001_EcommerceList_en.ets
// E-commerce Product List with Filters
// Material-You vivid
// en
// 1280x720

interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: ResourceColor;
}

@Entry
@Component
struct EcommerceList {
  @State selectedCategory: string = 'All';
  @State filters: string[] = ['In Stock'];
  @State products: ProductUi[] = [];

  aboutToAppear() {
    const palette: ResourceColor[] = [
      '#FFE0E7FF', '#FFD1FAE5', '#FFFFEDD5', '#FFFDE68A',
      '#FFEDE9FE', '#FFFFE4E6', '#FFE2E8F0', '#FFFFFBEB'
    ];
    const newProducts: ProductUi[] = [];
    for (let i = 0; i < 8; i++) {
      newProducts.push({
        id: i,
        title: `Product ${i + 1}`,
        price: `$${Math.floor(Math.random() * 41) + 9}.99`,
        badge: i % 3 === 0 ? 'NEW' : i % 4 === 0 ? 'SALE' : '',
        rating: `${Math.floor(Math.random() * 2) + 4}.${Math.floor(Math.random() * 10)}`,
        color: palette[i % palette.length]
      });
    }
    this.products = newProducts;
  }

  toggleFilter(label: string) {
    const index = this.filters.indexOf(label);
    if (index >= 0) {
      this.filters.splice(index, 1);
    } else {
      this.filters.push(label);
    }
  }

  build() {
    Column() {
      // Top App Bar
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF111827')
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFCFCFF');

      // Main Content
      Scroll() {
        Column() {
          // Category Row
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'], (item: string) => {
              Text(item)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedCategory === item ? '#FFFFFFFF' : '#FF111827')
                .backgroundColor(this.selectedCategory === item ? '#FF6750A4' : '#FFFCFCFF')
                .border({ width: 1, color: '#FFD0D5DD', radius: 8 })
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .margin({ right: 4, bottom: 4 })
                .onClick(() => {
                  this.selectedCategory = item;
                });
            });
          }
          .width('100%')
          .margin({ bottom: 6 });

          // Filter Row
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(['In Stock', 'Under $20', 'Rating 4+'], (item: string) => {
              Text(item)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.filters.includes(item) ? '#FF0A0F0A' : '#FF111827')
                .backgroundColor(this.filters.includes(item) ? '#FF6CC24A' : '#FFFCFCFF')
                .border({ width: 1, color: '#FFD0D5DD', radius: 4 })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ right: 4, bottom: 4 })
                .onClick(() => {
                  this.toggleFilter(item);
                });
            });
          }
          .width('100%')
          .margin({ bottom: 8 });

          // Product Grid
          Grid() {
            ForEach(this.products, (p: ProductUi) => {
              GridItem() {
                // Product Card
                Column() {
                  // Image Placeholder
                  Stack({ alignContent: Alignment.Center }) {
                    Text('Image')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FF111827');
                  }
                  .width('100%')
                  .aspectRatio(1.2)
                  .backgroundColor(p.color)
                  .borderRadius(8);

                  // Title and Badge
                  Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                    Text(p.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FF111827')
                      .layoutWeight(1)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis });

                    if (p.badge.length > 0) {
                      Text(p.badge)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#FF1F1400')
                        .backgroundColor('#FFFFB300')
                        .borderRadius(4)
                        .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                        .margin({ left: 4 });
                    }
                  }
                  .width('100%')
                  .margin({ top: 6 });

                  // Price
                  Text(p.price)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FF6750A4')
                    .margin({ top: 4 });

                  // Rating
                  Flex({ alignItems: ItemAlign.Center }) {
                    Stack() {}
                      .width(10)
                      .height(10)
                      .backgroundColor('#FFF59E0B')
                      .borderRadius(2)
                      .margin({ right: 4 });

                    Text(`${p.rating} rating`)
                      .fontSize(12)
                      .fontColor('#FF111827');
                  }
                  .width('100%')
                  .margin({ top: 4 });

                  // Add to Cart Button
                  Button('Add to Cart')
                    .type(ButtonType.Normal)
                    .borderRadius(8)
                    .backgroundColor('#FF6750A4')
                    .fontColor('#FFFFFFFF')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .width('100%')
                    .height(40)
                    .margin({ top: 6 });
                }
                .padding(8)
                .backgroundColor('#FFFCFCFF')
                .border({ width: 1, color: '#FFD0D5DD', radius: 12 })
                .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 });
              }
            });
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding({ bottom: 16 })
          .width('100%');
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 });
      }
      .layoutWeight(1)
      .backgroundColor('#FFF6F7FB');

      // Bottom Action Bar
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Column() {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF111827');
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF111827')
            .margin({ top: 2 });
        }
        .alignItems(HorizontalAlign.Start);

        Button('Checkout')
          .type(ButtonType.Normal)
          .borderRadius(12)
          .backgroundColor('#FF6CC24A')
          .fontColor('#FF0A0F0A')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .height(44)
          .width(140);
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#FFFCFCFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1 });
    }
    .width('100%')
    .height('100%');
  }
}
@Entry
@Component
struct Index {
  @State categories: string[] = ["Warehouse", "Device", "Office"]
  @State enabledCats: string[] = ["Warehouse", "Device", "Office"]
  @State assetName: string = ""
  @State assetCode: string = ""
  @State assetType: string = "Device"
  @State selectedText: string = "None"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Column (Main Content) ===
      Column({ space: 16 }) {
        // === LazyRow (Filter Chips) ===
        List({ space: 8 }) {
          ForEach(this.categories, (c: string) => {
            ListItem() {
              Button(c)
                .type(ButtonType.Normal)
                .backgroundColor(this.enabledCats.includes(c) ? '#121212' : '#E0E0E0')
                .fontColor(this.enabledCats.includes(c) ? '#FFFFFF' : '#333333')
                .borderRadius(12)
                .height(40)
                .onClick(() => {
                  if (this.enabledCats.includes(c)) {
                    this.enabledCats = this.enabledCats.filter(item => item !== c);
                  } else {
                    this.enabledCats.push(c);
                  }
                })
            }
          }, (c: string) => c)
        }.width('100%').layoutWeight(0).listDirection(Axis.Horizontal)

        // === Row (Form & Map) ===
        Row({ space: 16 }) {
          // === Left Column (Inputs) ===
          Column({ space: 12 }) {
            TextInput({ placeholder: 'Asset Name' })
              .backgroundColor('#EAE5EE')
              .borderRadius(8)
              .height(56)
              .placeholderColor('#757575')
              .onChange((value: string) => { this.assetName = value })

            TextInput({ placeholder: 'Asset Code' })
              .backgroundColor('#EAE5EE')
              .borderRadius(8)
              .height(56)
              .placeholderColor('#757575')
              .onChange((value: string) => { this.assetCode = value })

            TextInput({ text: this.assetType, placeholder: 'Asset Type' })
              .backgroundColor('#EAE5EE')
              .borderRadius(8)
              .height(56)
              .placeholderColor('#757575')
              .onChange((value: string) => { this.assetType = value })

            // Selected Card
            Column() {
              Text('Selected')
                .fontSize(14)
                .fontColor('#757575')
                .margin({ bottom: 4 })
              Text(this.selectedText)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#121212')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          }.layoutWeight(1)

          // === Right Box (Map Grid) ===
          Stack() {
            // Grid Lines Background
            Column() {
              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(Array.from({ length: 100 }), () => {
                  Divider().width('9%').height(1).color('#E0E0E0')
                }, () => '')
              }.width('100%').height('100%')
            }.width('100%').height('100%')

            // Vertical Lines Overlay
            Row() {
              ForEach(Array.from({ length: 10 }), () => {
                Divider().height('100%').width(1).color('#E0E0E0')
              }, () => '')
            }.width('100%').height('100%')

            // Markers
            // Warehouse Marker 1
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 24, height: 24 }).fill('#555555')
              Text('Warehouse')
                .fontSize(12)
                .fontColor('#121212')
                .backgroundColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(8)
                .position({ x: 32, y: -10 })
                .shadow({ radius: 2, color: '#33000000' })
            }.position({ left: '20%', top: '30%' })

            // Device Marker
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 24, height: 24 }).fill('#121212')
              Text('Device')
                .fontSize(12)
                .fontColor('#121212')
                .backgroundColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(8)
                .position({ x: 32, y: -10 })
                .shadow({ radius: 2, color: '#33000000' })
            }.position({ left: '50%', top: '45%' })

            // Office Marker
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 24, height: 24 }).fill('#121212')
              Text('Office')
                .fontSize(12)
                .fontColor('#121212')
                .backgroundColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(8)
                .position({ x: 32, y: -10 })
                .shadow({ radius: 2, color: '#33000000' })
            }.position({ left: '70%', top: '60%' })

            // Warehouse Marker 2
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 24, height: 24 }).fill('#555555')
              Text('Warehouse')
                .fontSize(12)
                .fontColor('#121212')
                .backgroundColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(8)
                .position({ x: 32, y: -10 })
                .shadow({ radius: 2, color: '#33000000' })
            }.position({ left: '30%', top: '75%' })

          }
          .width('100%')
          .aspectRatio(1)
          .backgroundColor('#F6F6F6')
          .borderRadius(20)
          .border({ width: 1, color: '#E0E0E0' })
          .layoutWeight(1)
        }.alignItems(VerticalAlign.Top).width('100%').layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // === Top App Bar ===
      Text('Asset Inventory')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#121212')
        .textAlign(TextAlign.Center)
        .width('100%')
        .position({ x: 0, y: 40 })

      // === Bottom Action Bar ===
      Column() {
        Row({ space: 16 }) {
          Button('Reset')
            .type(ButtonType.Normal)
            .backgroundColor('#F0F0F0')
            .fontColor('#121212')
            .borderRadius(16)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.assetName = '';
              this.assetCode = '';
              this.assetType = 'Device';
              this.selectedText = 'None';
            })

          Button('Save Asset')
            .type(ButtonType.Normal)
            .backgroundColor('#121212')
            .fontColor('#FFFFFF')
            .borderRadius(16)
            .height(48)
            .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }
}
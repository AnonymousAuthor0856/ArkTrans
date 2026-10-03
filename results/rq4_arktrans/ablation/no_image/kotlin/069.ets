@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'
  @State filters: Array<{ label: string, value: string }> = [
    { label: 'All', value: 'all' },
    { label: 'Pending', value: 'pending' },
    { label: 'Active', value: 'active' }
  ]

  // Mock data for the UI structure
  private cards = [
    { title: 'Cargo A', id: 'ID-001', fill: '80%' },
    { title: 'Cargo B', id: 'ID-002', fill: '45%' },
    { title: 'Cargo C', id: 'ID-003', fill: '90%' },
    { title: 'Cargo D', id: 'ID-004', fill: '12%' }
  ]

  private entries = [
    { origin: 'NYC', destination: 'LAX', status: 'In flight' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (LazyColumn equivalent) ===
      List({ space: 16 }) {
        ListItem() {
          // === Row (Filters) ===
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: { label: string, value: string }) => {
              Button(filter.label)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilter === filter.value ? '#D0BCFF' : '#49454F')
                .fontColor(this.activeFilter === filter.value ? '#1C1B1F' : '#E6E1E5')
                .borderRadius(8)
                .onClick(() => {
                  this.activeFilter = filter.value
                })
            }, (item: { label: string }) => item.label)
          }.width('100%')
        }

        ListItem() {
          // === Text (Cargo grid) ===
          Text('Cargo grid')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
        }

        ListItem() {
          // === LazyVerticalGrid (Grid) ===
          Grid() {
            ForEach(this.cards, (card: { title: string, id: string, fill: string }) => {
              GridItem() {
                Column({ space: 8 }) {
                  // === Box (Image Placeholder) ===
                  Stack({ alignContent: Alignment.Center }) {
                    Stack({ alignContent: Alignment.Center }) {
                      // Inner circle placeholder
                    }
                    .width(60)
                    .height(60)
                    .backgroundColor('#79747E') // Tertiary approx
                    .borderRadius(30)
                  }
                  .width('100%')
                  .height(90)
                  .backgroundColor('#313033') // Surface approx

                  // === Column (Texts) ===
                  Column({ space: 4 }) {
                    Text(card.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FBEFE0')
                    
                    Text(card.id)
                      .fontSize(14)
                      .fontColor('#FBEFE0')
                    
                    Text(`Fill ${card.fill}`)
                      .fontSize(12)
                      .fontColor('#4ADE80') // Success color
                  }
                }
                .padding(16)
                .backgroundColor('#49454F') // SurfaceVariant approx
                .borderRadius(12)
              }
            }, (item: { id: string }) => item.id)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .height(320)
        }

        ListItem() {
          // === Text (Route manifest) ===
          Text('Route manifest')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
        }

        ListItem() {
          // === Row (Manifest Item) ===
          Row() {
            Column({ space: 4 }) {
              Text(`${this.entries[0].origin} → ${this.entries[0].destination}`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0')
              
              Text(this.entries[0].status)
                .fontSize(14)
                .fontColor(this.entries[0].status === 'Delayed' ? '#F4B400' : 
                           this.entries[0].status === 'In flight' ? '#4ADE80' : '#CAC4D0')
            }
            
            Blank()
            
            Button('Details')
              .type(ButtonType.Normal)
              .backgroundColor('#D0BCFF')
              .fontColor('#100C08')
              .borderRadius(8)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding(16)
          .backgroundColor('#49454F')
          .borderRadius(12)
        }
      }
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .layoutWeight(1)

      // === CenterAlignedTopAppBar ===
      Row() {
        Column({ space: 4 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
          
          Text('Logistics grid')
            .fontSize(12)
            .fontColor('#FBEFE0')
        }
        .alignItems(HorizontalAlign.Center)
        
        Blank()
        
        Button()
          .width(26)
          .height(26)
          .backgroundColor('#49454F')
          .borderRadius(13)
        
        Button()
          .width(26)
          .height(26)
          .backgroundColor('#49454F')
          .borderRadius(13)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#1C1B1F') // Surface with alpha approx

      // === Surface (Bottom Sheet / Manifest Filter) ===
      Column() {
        Row() {
          Column({ space: 4 }) {
            Text('Manifest filter')
              .fontSize(12)
              .fontColor('#FBEFE0')
            
            Text(this.activeFilter)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FBEFE0')
          }
          
          Blank()
          
          Button('Dispatch')
            .type(ButtonType.Normal)
            .backgroundColor('#9A82FF') // Primary approx
            .fontColor('#100C08')
            .borderRadius(12)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      }
      .backgroundColor('#19110D')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: -100 }) // Positioned to overlap slightly if needed, or just at bottom
  }
  .width('100%')
  .height('100%')
  .backgroundColor('#100C08')
}
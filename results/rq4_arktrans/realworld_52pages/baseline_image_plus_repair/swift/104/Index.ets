// CategorySelectionView.ets

@Entry
@Component
struct CategorySelectionView {
  @State isEditModeActive: boolean = false
  @State selectedCategory: string = "General"
  @State categories: string[] = ["General"]
  
  build() {
    Column() {
      // Top bar with Edit and Dismiss buttons
      Row() {
        Button(this.isEditModeActive ? "Done" : "Edit")
          .onClick(() => {
            this.isEditModeActive = !this.isEditModeActive
          })
          .fontColor('#8B7355')
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        Button('×', { type: ButtonType.Circle, stateEffect: true })
          .width(24)
          .height(24)
          .backgroundColor('#CCCCCC')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      
      // Title
      Text("Select a Category")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 20 })
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20 })
      
      // Categories grid
      GridContainer()
        .columnsTemplate(['1fr'])
        .rowsTemplate(['auto'])
        .width('100%')
        .padding({ left: 20, right: 20 })
        .childGridItem()
        .gridRow(1)
        .gridColumn(1)
        .build() {
          ForEach(this.categories, (category: string) => {
            CategoryButton({ category: category, isSelected: this.selectedCategory === category })
              .onClick(() => {
                this.selectedCategory = category
              })
          })
        }
      
      Blank()
      
      // Bottom button
      Button("All notes")
        .width(150)
        .height(50)
        .borderRadius(25)
        .backgroundColor('#F5F5F5')
        .border({ width: 3, color: '#999999' })
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
        .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct CategoryButton {
  @Prop category: string
  @Prop isSelected: boolean
  
  build() {
    Row() {
      Text(this.category)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
      
      Blank()
      
      if (this.isSelected) {
        Circle()
          .width(16)
          .height(16)
          .fill('#D4C5B0')
          .strokeWidth(2)
          .stroke('#A08C70')
      } else {
        Circle()
          .width(16)
          .height(16)
          .fill('transparent')
          .strokeWidth(2)
          .stroke('#CCCCCC')
      }
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .borderRadius(30)
    .linearGradient({
      angle: 90,
      colors: [
        ['#FFFFFF', 0],
        ['#E8DFD0', 1]
      ]
    })
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
    .margin({ bottom: 10 })
  }
}
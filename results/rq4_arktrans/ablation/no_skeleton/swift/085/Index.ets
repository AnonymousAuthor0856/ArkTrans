@Entry
@Component
struct BotanyApp {
  @State selectedTab: number = 0

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // modifier: { width: '100%', height: '100%' }
    // children: 3
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', layoutWeight: 1, backgroundColor: '#FFFFFF' }
      // children: 2
      Column({ space: 0 }) {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { top: 24, left: 24, right: 24, bottom: 8 }, justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row({ space: 0 }) {
          // === Button (Menu) ===
          // modifier: { width: 40, height: 40, backgroundColor: '#FAFAFA', borderRadius: 20 }
          // children: 1
          Button() {
            // === Image ===
            // modifier: { width: 24, height: 24, color: '#1A1C19' }
            Image($r('app.media.startIcon'))
          }.width(40).height(40).backgroundColor('#FAFAFA').borderRadius(20)

          // === Blank ===
          Blank()

          // === Button (Search) ===
          // modifier: { width: 40, height: 40, backgroundColor: '#FAFAFA', borderRadius: 20 }
          // children: 1
          Button() {
            // === Image ===
            // modifier: { width: 24, height: 24, color: '#1A1C19' }
            Image($r('app.media.startIcon'))
          }.width(40).height(40).backgroundColor('#FAFAFA').borderRadius(20)
        }.width('100%').padding({ top: 24, left: 24, right: 24, bottom: 8 }).justifyContent(FlexAlign.SpaceBetween)

        // === Scroll ===
        // props: { scroller: Scroller.new() }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll(new Scroller()) {
          // === Column ===
          // props: { space: 0 }
          // modifier: { width: '100%', paddingBottom: 80 }
          // children: 5
          Column({ space: 0 }) {
            // === Column (Header) ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: { left: 24, right: 24, top: 16, bottom: 16 }, alignItems: ItemAlign.Start }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Good Morning,' }
              // modifier: { fontSize: 16, color: '#757575' }
              Text('Good Morning,')
              // === Text ===
              // props: { text: 'My Jungle' }
              // modifier: { fontSize: 34, fontWeight: FontWeight.Bold, letterSpacing: -1, color: '#1A1C19' }
              Text('My Jungle')
            }.width('100%').padding({ left: 24, right: 24, top: 16, bottom: 16 }).alignItems(HorizontalAlign.Start)

            // === Text (Section Header) ===
            // props: { text: 'Pending Tasks' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#1A1C19', padding: { left: 24, right: 24, top: 12, bottom: 12 } }
            Text('Pending Tasks')

            // === Scroll (Horizontal) ===
            // props: { scroller: Scroller.new() }
            // modifier: { width: '100%', paddingBottom: 32 }
            // children: 1
            Scroll(new Scroller()) {
              // === Row ===
              // props: { space: 16 }
              // modifier: { width: '100%', padding: { left: 24, right: 24 } }
              // children: 2
              Row({ space: 16 }) {
                // === TaskCard ===
                // modifier: { width: 160, height: 180, backgroundColor: '#FAFAFA', borderRadius: 24, border: { width: 1, color: '#EEEEEE' } }
                // children: 1
                TaskCardComponent({ title: 'Watering', plantName: 'Monstera Deliciosa', urgency: 'Today' })

                // === TaskCard ===
                // modifier: { width: 160, height: 180, backgroundColor: '#FAFAFA', borderRadius: 24, border: { width: 1, color: '#EEEEEE' } }
                // children: 1
                TaskCardComponent({ title: 'Fertilize', plantName: 'Fiddle Leaf Fig', urgency: 'Tomorrow' })
              }.width('100%').padding({ left: 24, right: 24 })
            }.width('100%').scrollable(ScrollDirection.Horizontal).padding({ bottom: 32 })

            // === Text (Section Header) ===
            // props: { text: 'Your Collection' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#1A1C19', padding: { left: 24, right: 24, top: 12, bottom: 12 } }
            Text('Your Collection')

            // === PlantListItem ===
            // modifier: { width: '100%' }
            // children: 1
            PlantListComponent({ name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 })
          }.width('100%').padding({ bottom: 80 })
        }.width('100%').layoutWeight(1).scrollBar(BarState.Off)
      }.width('100%').layoutWeight(1).backgroundColor('#FFFFFF')

      // === FAB ===
      // modifier: { width: 56, height: 56, backgroundColor: '#1A1C19', borderRadius: 28, margin: { right: 24, bottom: 96 } }
      // children: 1
      Button() {
        // === Text (+) ===
        // props: { text: '+' }
        // modifier: { fontSize: 32, color: '#FFFFFF' }
        Text('+')
      }.width(56).height(56).backgroundColor('#1A1C19').borderRadius(28).margin({ right: 24, bottom: 96 })

      // === BottomNav ===
      // modifier: { width: '100%', backgroundColor: '#FFFFFF', shadow: { radius: 5, color: '#0D000000', offsetY: -2 } }
      // children: 1
      BottomNavComponent({ selectedTab: this.selectedTab })
    }.width('100%').height('100%')
  }
}

// === Component: TaskCard ===
@Component
struct TaskCardComponent {
  @State isChecked: boolean = false
  title: string = ''
  plantName: string = ''
  urgency: string = ''

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: 160, height: 180, padding: 16, backgroundColor: '#FAFAFA', borderRadius: 24, border: { width: this.isChecked ? 2 : 1, color: this.isChecked ? '#2E5E4E' : '#EEEEEE' } }
    // children: 2
    Column({ space: 0 }) {
      // === Row (Icon) ===
      // props: { space: 0 }
      // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
      // children: 1
      Row({ space: 0 }) {
        // === Circle (Icon BG) ===
        // modifier: { width: 40, height: 40, backgroundColor: this.isChecked ? '#2E5E4E' : '#FFFFFF', borderRadius: 20 }
        // children: 1
        Column() {
          // === Image ===
          // modifier: { width: 20, height: 20, color: this.isChecked ? '#FFFFFF' : '#1A1C19' }
          Image($r('app.media.startIcon'))
        }.width(40).height(40).backgroundColor(this.isChecked ? '#2E5E4E' : '#FFFFFF').borderRadius(20).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

        // === Blank ===
        Blank()
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      // === Column (Texts) ===
      // props: { space: 0 }
      // modifier: { width: '100%', layoutWeight: 1, alignItems: ItemAlign.Start, justifyContent: FlexAlign.End }
      // children: 3
      Column({ space: 0 }) {
        // === Text (Title) ===
        // props: { text: this.title }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#1A1C19' }
        Text(this.title)
        
        // === Text (Plant Name) ===
        // props: { text: this.plantName }
        // modifier: { fontSize: 12, color: '#757575', maxWidth: '100%', overflow: TextOverflow.Ellipsis }
        Text(this.plantName)
        
        // === Blank ===
        Blank().height(8)

        // === Text (Chip) ===
        // props: { text: this.isChecked ? 'DONE' : this.urgency }
        // modifier: { fontSize: 10, fontWeight: FontWeight.Bold, color: this.isChecked ? '#FFFFFF' : '#1A1C19', backgroundColor: this.isChecked ? '#2E5E4E' : '#E0E0E0', borderRadius: 4, padding: { left: 6, right: 6, top: 2, bottom: 2 } }
        Text(this.isChecked ? 'DONE' : this.urgency)
      }.width('100%').layoutWeight(1).alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.End)
    }.width(160).height(180).padding(16).backgroundColor('#FAFAFA').borderRadius(24).border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? '#2E5E4E' : '#EEEEEE' })
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

// === Component: PlantList ===
@Component
struct PlantListComponent {
  @State expanded: boolean = false
  name: string = ''
  scientificName: string = ''
  location: string = ''
  daysUntilWater: number = 0

  build() {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 16, backgroundColor: '#FAFAFA', borderRadius: 16, margin: { left: 24, right: 24, top: 8, bottom: 8 }, alignItems: ItemAlign.Center }
    // children: 3
    Row({ space: 16 }) {
      // === Box (Image Placeholder) ===
      // modifier: { width: 56, height: 56, backgroundColor: '#EEEEEE', borderRadius: 12 }
      // children: 1
      Column() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: this.daysUntilWater == 0 ? '#2E5E4E' : '#CCCCCC' }
        Image($r('app.media.startIcon'))
      }.width(56).height(56).backgroundColor('#EEEEEE').borderRadius(12).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

      // === Column (Info) ===
      // props: { space: 0 }
      // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
      // children: 2
      Column({ space: 0 }) {
        // === Text (Name) ===
        // props: { text: this.name }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#1A1C19' }
        Text(this.name)
        
        // === Text (Scientific) ===
        // props: { text: this.scientificName }
        // modifier: { fontSize: 12, color: '#757575', fontStyle: FontStyle.Italic }
        Text(this.scientificName)

        if (this.expanded) {
          // === Row (Location) ===
          // props: { space: 4 }
          // modifier: { marginTop: 8, alignItems: ItemAlign.Center }
          // children: 2
          Row({ space: 4 }) {
            // === Image ===
            // modifier: { width: 12, height: 12, color: '#757575' }
            Image($r('app.media.startIcon'))
            
            // === Text ===
            // props: { text: this.location }
            // modifier: { fontSize: 10, color: '#757575' }
            Text(this.location)
          }.margin({ top: 8 }).alignItems(VerticalAlign.Center)
        }
      }.layoutWeight(1).alignItems(HorizontalAlign.Start)

      // === Column (Status) ===
      // props: { space: 0 }
      // modifier: { alignItems: ItemAlign.End }
      // children: 1
      Column({ space: 0 }) {
        if (this.daysUntilWater == 0) {
          // === Image ===
          // modifier: { width: 24, height: 24, color: '#2E5E4E' }
          Image($r('app.media.startIcon'))
          
          // === Text ===
          // props: { text: 'Water' }
          // modifier: { fontSize: 10, fontWeight: FontWeight.Bold, color: '#2E5E4E' }
          Text('Water')
        } else {
          // === Text ===
          // props: { text: `${this.daysUntilWater} days` }
          // modifier: { fontSize: 10, color: '#757575' }
          Text(`${this.daysUntilWater} days`)
        }
      }.alignItems(HorizontalAlign.End)
    }.width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16).margin({ left: 24, right: 24, top: 8, bottom: 8 }).alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

// === Component: BottomNav ===
@Component
struct BottomNavComponent {
  selectedTab: number = 0

  build() {
    // === Row ===
    // props: { space: 0 }
    // modifier: { width: '100%', padding: { left: 48, right: 48, top: 24, bottom: 24 }, backgroundColor: '#FFFFFF', shadow: { radius: 5, color: '#0D000000', offsetY: -2 }, justifyContent: FlexAlign.SpaceBetween }
    // children: 4
    Row({ space: 0 }) {
      // === NavItem (Home) ===
      // modifier: { opacity: this.selectedTab == 0 ? 1.0 : 0.4 }
      // children: 1
      Column() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: '#1A1C19' }
        Image($r('app.media.startIcon'))
      }.opacity(this.selectedTab == 0 ? 1.0 : 0.4)

      // === NavItem (Calendar) ===
      // modifier: { opacity: this.selectedTab == 1 ? 1.0 : 0.4 }
      // children: 1
      Column() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: '#1A1C19' }
        Image($r('app.media.startIcon'))
      }.opacity(this.selectedTab == 1 ? 1.0 : 0.4)

      // === Spacer (FAB Gap) ===
      // modifier: { width: 32 }
      Blank().width(32)

      // === NavItem (Bell) ===
      // modifier: { opacity: this.selectedTab == 2 ? 1.0 : 0.4 }
      // children: 1
      Column() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: '#1A1C19' }
        Image($r('app.media.startIcon'))
      }.opacity(this.selectedTab == 2 ? 1.0 : 0.4)

      // === NavItem (Settings) ===
      // modifier: { opacity: this.selectedTab == 3 ? 1.0 : 0.4 }
      // children: 1
      Column() {
        // === Image ===
        // modifier: { width: 24, height: 24, color: '#1A1C19' }
        Image($r('app.media.startIcon'))
      }.opacity(this.selectedTab == 3 ? 1.0 : 0.4)
    }.width('100%').padding({ left: 48, right: 48, top: 24, bottom: 24 }).backgroundColor('#FFFFFF').shadow({ radius: 5, color: '#0D000000', offsetY: -2 }).justifyContent(FlexAlign.SpaceBetween)
  }
}
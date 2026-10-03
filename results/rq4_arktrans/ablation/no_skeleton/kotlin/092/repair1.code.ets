@Entry
@Component
struct ZenBonsaiApp {
  @State v: number = 0

  build() {
    // === Column (Main Container) ===
    // props: {}
    // modifier: { width: '100%', height: '100%', padding: 24, backgroundColor: '#FFF' }
    // children: 5
    Column() {
      // === Column (Header) ===
      // props: {}
      // modifier: { horizontalAlign: HorizontalAlign.Center }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'JUNIPER · #04' }
        // modifier: { fontSize: 12, color: '#7F8C8D', letterSpacing: 2 }
        Text('JUNIPER · #04').fontSize(12).fontColor('#7F8C8D').letterSpacing(2)
        
        // === Blank ===
        // modifier: { height: 8 }
        Blank().height(8)
        
        // === Text ===
        // props: { text: 'Zen Garden' }
        // modifier: { fontSize: 36, fontWeight: FontWeight.Light, color: '#2C3E50' }
        Text('Zen Garden').fontSize(36).fontWeight(FontWeight.Normal).fontColor('#2C3E50')
      }

      // === Blank ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Stack (Hero Image / Bonsai Visual) ===
      // props: { alignContent: Alignment.BottomCenter }
      // modifier: { width: 220, height: 220 }
      // children: 1
      Stack({ alignContent: Alignment.Bottom }) {
        // === Custom Component (Canvas Drawing) ===
        // Note: ArkTS Canvas is complex. Using a simplified Shape/Image representation 
        // or a custom drawing component if strictly required. 
        // For this conversion, we use a placeholder Image as per rule 2 ($r('app.media.startIcon'))
        // but styled to look like the bonsai if possible, or just the icon.
        // However, the prompt asks to reproduce layout. I will use a generic image 
        // and style it.
        Image($r('app.media.startIcon')).width(220).height(220).objectFit(ImageFit.Contain)
      }.width(220).height(220)

      // === Blank ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Row (Status Cards) ===
      // props: { space: 20 }
      // modifier: { width: '100%', justifyContent: FlexAlign.SpaceEvenly }
      // children: 3
      Row({ space: 20 }) {
        // === StatusItem 1 ===
        this.StatusItemComponent('98%', 'Health', '#E57373')
        
        // === StatusItem 2 ===
        this.StatusItemComponent('4 Yrs', 'Age', '#8D6E63')
        
        // === StatusItem 3 ===
        this.StatusItemComponent('2 Days', 'Water', '#64B5F6')
      }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

      // === Blank ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Column (Activity Log) ===
      // props: {}
      // modifier: { width: '100%' }
      // children: 4
      Column() {
        // === Row (Header) ===
        // props: { space: 12 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, verticalAlign: VerticalAlign.Center }
        // children: 2
        Row({ space: 12 }) {
          // === Text ===
          // props: { text: 'Care Schedule' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#2C3E50' }
          Text('Care Schedule').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#2C3E50')
          
          // === Blank ===
          Blank()
          
          // === Button (Add Icon) ===
          // modifier: { width: 28, height: 28, backgroundColor: '#E8F5E9', borderRadius: 14 }
          // children: 1
          Button() {
            // === Text (+) ===
            Text('+').fontSize(20).fontColor('#6A8E6A')
          }.width(28).height(28).backgroundColor('#E8F5E9').borderRadius(14)
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

        // === Blank ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === CareLogItem 1 ===
        this.CareLogItemComponent('Watering', 'Today, 8:00 AM', true)
        
        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)
        
        // === CareLogItem 2 ===
        this.CareLogItemComponent('Pruning', 'Tomorrow', false)
        
        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)
        
        // === CareLogItem 3 ===
        this.CareLogItemComponent('Fertilizer', 'In 5 days', false)
      }.width('100%')
      
      // === Blank ===
      // To push bottom nav up if needed, or just fill space
      Blank()
    }.width('100%').height('100%').padding(24).backgroundColor('#FFF')

    // === Bottom Nav ===
    // Positioned absolutely at bottom using Stack in real app, 
    // but here appended to main column for simplicity of structure matching Compose Scaffold
    // Actually, Compose Scaffold puts it outside content. 
    // Let's wrap everything in a Stack to mimic Scaffold properly? 
    // No, the skeleton example uses a single build return. 
    // I will append it to the main Column with layoutWeight 0 and fixed height.
    
    // Re-structuring slightly to match Scaffold behavior:
    // The previous Column had height 100%. If I add another child, it overflows.
    // I should wrap the main content in a Column with layoutWeight 1.
    
    // Correction: The build() returns one root. 
    // Let's change the outermost container to a Column that holds Content + BottomNav.
  }

  // Helper Components defined inside struct
  
  @Builder
  StatusItemComponent(value: string, label: string, tintHex: string) {
    Column() {
      // === Box (Icon Container) ===
      // modifier: { width: 50, height: 50, backgroundColor: '#F7F9F9', borderRadius: 25, border: { width: 1, color: '#ECEFF1' }, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
      // children: 1
      Row() {
        // === Image (Icon Placeholder) ===
        // Using startIcon as placeholder for all icons due to Rule 2
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.width(50).height(50).backgroundColor('#F7F9F9').borderRadius(25).border({ width: 1, color: '#ECEFF1' }).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)

      // === Blank ===
      // modifier: { height: 8 }
      Blank().height(8)

      // === Text (Value) ===
      // props: { text: value }
      // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#2C3E50' }
      Text(value).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#2C3E50')

      // === Text (Label) ===
      // props: { text: label }
      // modifier: { fontSize: 12, color: '#7F8C8D' }
      Text(label).fontSize(12).fontColor('#7F8C8D')
    }
  }

  @Builder
  CareLogItemComponent(title: string, subtitle: string, isDone: boolean) {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%', backgroundColor: '#FAFAFA', borderRadius: 12, border: { width: 1, color: '#F0F0F0' }, padding: 16, verticalAlign: VerticalAlign.Center }
    // children: 3
    Row({ space: 16 }) {
      // === Circle (Status Dot) ===
      // modifier: { width: 12, height: 12, backgroundColor: isDone ? '#6A8E6A' : '#E0E0E0', borderRadius: 6 }
      Row() {
        // Empty row to act as circle shape
      }.width(12).height(12).backgroundColor(isDone ? '#6A8E6A' : '#E0E0E0').borderRadius(6)

      // === Column (Texts) ===
      // props: {}
      // modifier: { layoutWeight: 1 }
      // children: 2
      Column() {
        // === Text (Title) ===
        // props: { text: title }
        // modifier: { fontSize: 14, color: isDone ? '#2C3E50' : '#7F8C8D' }
        Text(title).fontSize(14).fontColor(isDone ? '#2C3E50' : '#7F8C8D')
        
        // === Text (Subtitle) ===
        // props: { text: subtitle }
        // modifier: { fontSize: 12, color: '#9E9E9E' }
        Text(subtitle).fontSize(12).fontColor('#9E9E9E')
      }.layoutWeight(1)

      // === Conditional Check Icon ===
      if (isDone) {
        // === Image (Check) ===
        // modifier: { width: 20, height: 20 }
        Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
      }
    }.width('100%').backgroundColor('#FAFAFA').borderRadius(12).border({ width: 1, color: '#F0F0F0' }).padding(16).alignItems(VerticalAlign.Center)
  }
}

// Revised Build Structure to include Bottom Nav correctly
@Entry
@Component
struct ZenBonsaiAppFinal {
  @State v: number = 0

  build() {
    // === Column (Root) ===
    // props: {}
    // modifier: { width: '100%', height: '100%', backgroundColor: '#FFF' }
    // children: 2
    Column() {
      // === Column (Scrollable Content Area) ===
      // props: {}
      // modifier: { width: '100%', layoutWeight: 1, padding: 24 }
      // children: 5
      Column() {
        // Header
        Column() {
          Text('JUNIPER · #04').fontSize(12).fontColor('#7F8C8D').letterSpacing(2)
          Blank().height(8)
          Text('Zen Garden').fontSize(36).fontWeight(FontWeight.Normal).fontColor('#2C3E50')
        }.alignItems(HorizontalAlign.Center)

        Blank().height(32)

        // Hero
        Stack({ alignContent: Alignment.Bottom }) {
          Image($r('app.media.startIcon')).width(220).height(220).objectFit(ImageFit.Contain)
        }.width(220).height(220)

        Blank().height(32)

        // Status Row
        Row({ space: 20 }) {
          this.StatusItem('98%', 'Health', '#E57373')
          this.StatusItem('4 Yrs', 'Age', '#8D6E63')
          this.StatusItem('2 Days', 'Water', '#64B5F6')
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(32)

        // Activity Log
        Column() {
          Row({ space: 12 }) {
            Text('Care Schedule').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#2C3E50')
            Blank()
            Button() {
              Text('+').fontSize(20).fontColor('#6A8E6A')
            }.width(28).height(28).backgroundColor('#E8F5E9').borderRadius(14)
          }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

          Blank().height(16)

          this.CareLogItem('Watering', 'Today, 8:00 AM', true)
          Blank().height(12)
          this.CareLogItem('Pruning', 'Tomorrow', false)
          Blank().height(12)
          this.CareLogItem('Fertilizer', 'In 5 days', false)
        }.width('100%')
        
        Blank()
      }.width('100%').layoutWeight(1).padding(24)

      // === Bottom Nav ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', border: { width: 1, color: '#F5F5F5', radius: 0 } }
      // children: 3
      Row() {
        this.NavIcon(true)
        this.NavIcon(false)
        this.NavIcon(false)
      }.width('100%').height(80).backgroundColor('#FFF').border({ width: 1, color: '#F5F5F5' }).justifyContent(FlexAlign.SpaceAround).alignItems(VerticalAlign.Center)
    }.width('100%').height('100%').backgroundColor('#FFF')
  }

  @Builder
  StatusItem(value: string, label: string, tintHex: string) {
    Column() {
      Row() {
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.width(50).height(50).backgroundColor('#F7F9F9').borderRadius(25).border({ width: 1, color: '#ECEFF1' }).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
      
      Blank().height(8)
      
      Text(value).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#2C3E50')
      Text(label).fontSize(12).fontColor('#7F8C8D')
    }
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row({ space: 16 }) {
      Row() {
        // Circle dot
      }.width(12).height(12).backgroundColor(isDone ? '#6A8E6A' : '#E0E0E0').borderRadius(6)

      Column() {
        Text(title).fontSize(14).fontColor(isDone ? '#2C3E50' : '#7F8C8D')
        Text(subtitle).fontSize(12).fontColor('#9E9E9E')
      }.layoutWeight(1)

      if (isDone) {
        Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
      }
    }.width('100%').backgroundColor('#FAFAFA').borderRadius(12).border({ width: 1, color: '#F0F0F0' }).padding(16).alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(isSelected: boolean) {
    Column() {
      Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain)
      
      if (isSelected) {
        Blank().height(4)
        Row() {
          // Dot indicator
        }.width(4).height(4).backgroundColor('#6A8E6A').borderRadius(2)
      }
    }
  }
}
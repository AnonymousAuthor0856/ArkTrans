// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct QuizForgePage {
  @State selectedIndex: number = -1;
  private progressValue: number = 0.45;

  // Design Tokens
  private colors = {
    primary: '#FF8A2A',
    secondary: '#FFC857',
    tertiary: '#68D672',
    background: '#FFF9F2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE4CC',
    outline: '#E2B088',
    onSurface: '#311F10',
    onBackground: '#1E1205'
  }

  private spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28
  }

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Circle({ width: 30, height: 30 })
          .fill(this.colors.surfaceVariant)
        
        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
          
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Gray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        
        Circle({ width: 30, height: 30 })
          .fill('#FF8A2A')
          .opacity(0.35)
      }
      .width('100%')
      .padding({ left: this.spacing.lg, right: this.spacing.lg, top: this.spacing.md, bottom: this.spacing.sm })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Question Card
          Column() {
            // Category and Progress %
            Row() {
              Text('Citrus crafts')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
              
              Blank()
              
              Text('45%')
                .fontSize(14)
                .fontColor(this.colors.secondary)
            }
            .width('100%')
            
            // Progress Bar
            Row() {
              LinearProgress({ value: this.progressValue, color: this.colors.primary })
            }
            .width('100%')
            .margin({ top: this.spacing.xs })
            
            // Question Prompt
            Text('Which zest carrier gives the brightest aroma when infused cold?')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.colors.onSurface)
              .lineHeight(28)
              .margin({ top: this.spacing.sm })
            
            // Options List
            Column() {
              this.buildOptionChip('Dried peel sachet', 0)
              this.buildOptionChip('Twist garnish', 1)
              this.buildOptionChip('Zester microplane', 2)
              this.buildOptionChip('Candied strip', 3)
            }
            .margin({ top: this.spacing.sm })
            .width('100%')
            .childLayout({
              type: ChildType.COLUMN,
              alignItems: ItemAlign.Stretch,
              justifyContent: FlexAlign.Start,
              childSpacing: this.spacing.xs
            })
            
            // Hint Box
            Row() {
              Text('Hint: Think surface area')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
            }
            .backgroundColor('#FFC857')
            .opacity(0.2)
            .borderRadius(10)
            .padding({ left: this.spacing.sm, right: this.spacing.sm, top: this.spacing.xs, bottom: this.spacing.xs })
            .margin({ top: this.spacing.sm })
            .alignSelf(ItemAlign.Start)
          }
          .backgroundColor(this.colors.background)
          .borderRadius(28)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
          .padding(this.spacing.md)
          .width('100%')
          
          // Trackers Section
          Column() {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.colors.onSurface)
              .margin({ top: this.spacing.md })
            
            Row() {
              this.buildTrackerCard('Current streak', '5 days')
              this.buildTrackerCard('Accuracy', '84%')
              this.buildTrackerCard('Rank', 'Top 12%')
            }
            .width('100%')
            .margin({ top: this.spacing.xs })
            .childLayout({
              type: ChildType.ROW,
              alignItems: ItemAlign.Center,
              justifyContent: FlexAlign.SpaceBetween,
              childSpacing: this.spacing.sm
            })
            
            // Submit Button
            Button('Submit answer')
              .type(ButtonType.Capsule)
              .backgroundColor(this.colors.primary)
              .fontColor('#2C0D00')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .height(48)
              .margin({ top: this.spacing.md })
              .onClick(() => {
                // Handle submit
              })
          }
          .width('100%')
          .margin({ top: this.spacing.md })
        }
        .padding({ left: this.spacing.lg, right: this.spacing.lg, bottom: this.spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .backgroundColor(this.colors.background)
    .width('100%')
    .height('100%')
  }

  @Builder
  buildOptionChip(text: string, index: number) {
    Row() {
      Text(text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
    }
    .width('100%')
    .height(50)
    .borderRadius(18)
    .border({
      width: 1,
      color: this.selectedIndex === index ? this.colors.primary : this.colors.outline
    })
    .backgroundColor(this.selectedIndex === index ? '#FF8A2A' : this.colors.surfaceVariant)
    .opacity(this.selectedIndex === index ? 0.2 : 1)
    .padding({ left: this.spacing.sm, right: this.spacing.sm })
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.selectedIndex = index;
    })
  }

  @Builder
  buildTrackerCard(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Gray)
      
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .margin({ top: 2 })
    }
    .width('32%')
    .height(80)
    .backgroundColor(this.colors.surfaceVariant)
    .borderRadius(18)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

// Helper Components to mimic Compose primitives where needed or simplify layout

@Component
struct Circle {
  private width: number = 0;
  private height: number = 0;

  build() {
    Circle({ width: this.width, height: this.height })
  }
}

@Component
struct LinearProgress {
  private value: number = 0;
  private color: string = '#000000';

  build() {
    Stack() {
      // Background track
      Rect()
        .width('100%')
        .height(6)
        .borderRadius(3)
        .fill('#E0E0E0')
        .opacity(0.3)
      
      // Progress fill
      Rect()
        .width(`${this.value * 100}%`)
        .height(6)
        .borderRadius(3)
        .fill(this.color)
    }
    .width('100%')
    .height(6)
  }
}
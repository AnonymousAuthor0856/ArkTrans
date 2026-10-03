@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column() {
            // === VStack ===
            Column() {
              // === Text ===
              Text('JUNIPER · #04')
                .letterSpacing(2)
                .fontColor('#757575') // zenTextSecondary approximation
                .fontSize(12) // AppTypography.labelMedium approximation

              // === Spacer ===
              Blank().height(8)

              // === Text ===
              Text('Zen Garden')
                .fontColor('#212121') // zenTextPrimary approximation
                .fontSize(36) // AppTypography.displaySmallLight approximation
            }

            // === Spacer ===
            Blank().height(32)

            // === Canvas ===
            // Note: ArkTS Canvas requires a specific builder. Using a placeholder Container for layout structure as per skeleton intent, 
            // or an empty Canvas if strictly following "Canvas" node. 
            // Since no drawing logic is provided in skeleton, we use a Container to represent the visual block or an empty Canvas.
            // To ensure compilation without errors regarding missing canvas context, we use a simple Container/Column with height if it's just a spacer, 
            // but the skeleton says Canvas. We will use a Container with fixed size or weight to mimic the frame(maxWidth: infinity...) behavior in a list.
            // However, standard Canvas needs a builder. Let's use a Column with layoutWeight to fill space if it's meant to be the main content area,
            // or a fixed height box. Given "maxHeight: infinity", it likely expands.
            // For strict compilability without complex canvas logic not present in skeleton:
            Column() {
              // Placeholder for Canvas content
            }.width('100%').height(200) // Approximating the visual space of the garden view

            // === Spacer ===
            Blank().height(32)

            // === HStack ===
            Row() {
              // === Spacer ===
              Blank()

              // === StatusItem ===
              StatusItem({ props: { icon: 'heart.fill', label: 'Health', value: '98%', tint: '#FF5252' } })

              // === Spacer ===
              Blank()

              // === StatusItem ===
              StatusItem({ props: { icon: 'calendar', label: 'Age', value: '4 Yrs', tint: '#795548' } })

              // === Spacer ===
              Blank()

              // === StatusItem ===
              StatusItem({ props: { icon: 'checkmark.circle.fill', label: 'Water', value: '2 Days', tint: '#2196F3' } })

              // === Spacer ===
              Blank()
            }.width('100%')

            // === Spacer ===
            Blank().height(32)

            // === VStack ===
            Column() {
              // === HStack ===
              Row() {
                // === Text ===
                Text('Care Schedule')
                  .fontColor('#212121')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // === Spacer ===
                Blank()

                // === Image ===
                // Using $r('app.media.startIcon') as per rules, though skeleton implies a system icon "plus"
                // We style it to look like the button described
                Image($r('app.media.startIcon'))
                  .onClick(() => {
                    // Handle add log action
                  })
                  .width(28)
                  .height(28)
                  .clipShape(Circle())
                  .backgroundColor('#E8F5E9')
                  .padding(4)
                  .objectFit(ImageFit.Contain)
              }.width('100%')

              // === Spacer ===
              Blank().height(16)

              // === CareLogItem ===
              CareLogItem({ props: { title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true } })

              // === Spacer ===
              Blank().height(12)

              // === CareLogItem ===
              CareLogItem({ props: { title: 'Pruning', subtitle: 'Tomorrow', isDone: false } })

              // === Spacer ===
              Blank().height(12)

              // === CareLogItem ===
              CareLogItem({ props: { title: 'Fertilizer', subtitle: 'In 5 days', isDone: false } })
            }.width('100%')
          }
          .padding({ left: 24, right: 24, bottom: 80 })
          .backgroundColor('#FFFFFF')
        }.backgroundColor('#FFFFFF')

        // === VStack (Bottom Bar) ===
        Column() {
          // === Rectangle ===
          Rect()
            .height(1)
            .fill('#F5F5F5')

          // === HStack ===
          Row() {
            // === NavIcon ===
            NavIcon({ props: { icon: 'house.fill', isSelected: true } })
            
            // === NavIcon ===
            NavIcon({ props: { icon: 'info.circle.fill', isSelected: false } })
            
            // === NavIcon ===
            NavIcon({ props: { icon: 'gearshape.fill', isSelected: false } })
          }
          .width('100%')
          .height(80)
          .backgroundColor('#FFFFFF')
        }
      }
    }.width('100%').height('100%')
  }
}

// --- Supporting Components & Interfaces ---

interface StatusItemProps {
  icon: string;
  label: string;
  value: string;
  tint: string;
}

@Component
struct StatusItem {
  private props: StatusItemProps = { icon: '', label: '', value: '', tint: '' };

  build() {
    Column() {
      // Icon placeholder using Image since system icons aren't directly available as components in basic ArkTS without @ohos.graphics
      // Using startIcon as fallback resource
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
      
      Text(this.props.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 4 })
      
      Text(this.props.label)
        .fontSize(12)
        .fontColor('#757575')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

interface CareLogItemProps {
  title: string;
  subtitle: string;
  isDone: boolean;
}

@Component
struct CareLogItem {
  private props: CareLogItemProps = { title: '', subtitle: '', isDone: false };

  build() {
    Row() {
      // Checkbox indicator
      Circle()
        .width(24)
        .height(24)
        .fill(this.props.isDone ? '#4CAF50' : '#E0E0E0')
        .borderWidth(this.props.isDone ? 0 : 2)
        .borderColor('#BDBDBD')
      
      Column() {
        Text(this.props.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.props.isDone ? '#A5A5A5' : '#212121')
          .decoration({ type: this.props.isDone ? TextDecorationType.LineThrough : TextDecorationType.None })
        
        Text(this.props.subtitle)
          .fontSize(14)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }
}

interface NavIconProps {
  icon: string;
  isSelected: boolean;
}

@Component
struct NavIcon {
  private props: NavIconProps = { icon: '', isSelected: false };

  build() {
    Column() {
      // Icon placeholder
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .fillColor(this.props.isSelected ? '#4CAF50' : '#BDBDBD')
      
      // Optional label or indicator dot could go here
    }
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
  }
}
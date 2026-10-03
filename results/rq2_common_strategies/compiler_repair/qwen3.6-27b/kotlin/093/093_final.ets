import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// --- Domain Models ---
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

// --- Sample Data ---
const teaPresets: TeaPreset[] = [
  { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
  { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
  { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
  { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
  { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
];

@Entry
@Component
struct TeaMasterApp {
  @State selectedTea: TeaPreset = teaPresets[0];

  build() {
    Column() {
      // Header
      this.HeaderSection()

      Spacer()
        .height(32)

      // Visualization Circle
      this.BrewingVisualizer(this.selectedTea)

      Spacer()
        .height(40)

      // Stats Row
      this.BrewStatsRow(this.selectedTea)

      Spacer()
        .height(40)

      // Selection List
      this.TeaSelector(
        this.selectedTea,
        (tea: TeaPreset) => {
          this.selectedTea = tea;
        }
      )

      Spacer()
        .layoutWeight(1)

      // Action Button
      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }

      Blank()

      Button() {
        Image($r('app.media.settings')) 
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
      .onClick(() => {
        // No-op
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack() {
      // Inner Circle
      Column() {
        // Using a generic image or shape to represent the icon since we don't have vector assets directly
        // In a real app, use Image($r('app.media.heart_icon'))
        Circle()
          .width(48)
          .height(48)
          .fill('#8D6E63')
        
        Text(tea.name)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      
      // Background Circle
      Circle()
        .width(180)
        .height(180)
        .fill('#F5F5F5')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
    }
    .width(220)
    .height(220)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem("TEMP", tea.temp)
      this.VerticalDivider()
      this.InfoItem("TIME", tea.time)
      this.VerticalDivider()
      this.InfoItem("AMOUNT", "250ml")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  VerticalDivider() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .fontColor(Color.Gray)
      
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector(selected: TeaPreset, onSelect: (tea: TeaPreset) => void) {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ start: 4, bottom: 12 })

      LazyForEach(new ArrayDataSource(teaPresets), (preset: TeaPreset) => {
        this.TeaChip(
          preset,
          preset === selected,
          () => {
            onSelect(preset);
          }
        )
      }, (preset: TeaPreset) => preset.name)
      .itemSpace(12)
      .padding({ left: 4, right: 4 })
    }
    .width('100%')
  }

  @Builder
  TeaChip(preset: TeaPreset, isSelected: boolean, onClick: () => void) {
    Button(preset.name)
      .type(ButtonType.Normal)
      .backgroundColor(isSelected ? Color.Black : Color.White)
      .fontColor(isSelected ? Color.White : Color.Black)
      .borderWidth(1)
      .borderColor(isSelected ? Color.Black : '#E0E0E0')
      .borderRadius(50)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .onClick(onClick)
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        // Placeholder for Play Icon
        Triangle()
          .width(12)
          .height(12)
          .fillColor(Color.White)
          .rotate({ angle: -90 }) // Simple triangle approximation
        
        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .type(ButtonType.Normal)
    .backgroundColor(Color.Black)
    .width('100%')
    .height(56)
    .borderRadius(16)
    .onClick(() => {
      // No-op
    })
  }
}

// Helper component for simple shapes if needed, though standard shapes are preferred
@Component
struct Triangle {
  build() {
    Path()
      .moveTo(0, 0)
      .lineTo(12, 12)
      .lineTo(0, 24)
      .close()
      .width(12)
      .height(24)
  }
}

class ArrayDataSource<T> implements IDataSource {
  private data: T[];
  private listener: DataChangeListener | null = null;

  constructor(data: T[]) {
    this.data = data;
  }

  totalCount(): number {
    return this.data.length;
  }

  getData(index: number): T {
    return this.data[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener;
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    this.listener = null;
  }
}
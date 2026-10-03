// Translated from SwiftUI to ArkTS (HarmonyOS).
// SwiftUI: import SwiftUI / @main struct ForumPostApp: App { WindowGroup { ForumPostView() } }
// ArkTS: the app entry is expressed by the @Entry component ForumPostView.

class Author {
  name: string = ''
  avatarColor: string = ''

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Reply {
  id: number = 0
  author: Author = new Author('', '')
  timestamp: string = ''
  text: string = ''
  votes: number = 0

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

class Post {
  author: Author = new Author('', '')
  timestamp: string = ''
  title: string = ''
  body: string = ''
  votes: number = 0
  commentCount: number = 0

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

class FontToken {
  size: number = 0
  weight: FontWeight = FontWeight.Regular

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class ColorTokens {
  primary: string = '#00E5FF'
  secondary: string = '#FF00AA'
  tertiary: string = '#76FF03'
  background: string = '#101024'
  surface: string = '#1C1C3A'
  surfaceVariant: string = '#282850'
  outline: string = '#44446A'
  warning: string = '#FFD600'
  onPrimary: string = '#000000'
  onSurface: string = '#E0E0FF'
}

class TypographyTokens {
  title: FontToken = new FontToken(20, FontWeight.Medium) // 增大
  headline: FontToken = new FontToken(22, FontWeight.Bold) // 增大 (semibold)
  body: FontToken = new FontToken(18, FontWeight.Regular) // 增大
  label: FontToken = new FontToken(16, FontWeight.Medium) // 增大
  small: FontToken = new FontToken(14, FontWeight.Medium) // 增大
}

class ShapesTokens {
  small: number = 6
  medium: number = 12
  large: number = 20
}

class SpacingTokens {
  xs: number = 6
  sm: number = 10
  md: number = 16
  lg: number = 20
  xl: number = 28
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens()
  static readonly Typography: TypographyTokens = new TypographyTokens()
  static readonly Shapes: ShapesTokens = new ShapesTokens()
  static readonly Spacing: SpacingTokens = new SpacingTokens()
}

@Component
struct UpVoteArrow {
  color: string = '#FFFFFF'

  build() {
    Polygon({ width: 28, height: 28 })
      .points([[14, 0], [28, 14], [14, 28], [0, 14]])
      .fill(this.color)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', '')
  timestamp: string = ''

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 28, height: 28 })
          .fill(this.author.avatarColor)

        Circle({ width: 10, height: 10 })
          .fill('#000000')
          .opacity(0.2)
      }

      Text(this.author.name)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(AppTokens.Typography.small.weight)
        .fontColor(AppTokens.Colors.outline)
    }
  }
}

@Component
struct InfoChip {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.small.size)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct PostCard {
  post: Post = new Post(new Author('', ''), '', '', '', 0, 0)
  @Prop voteState: number = 1
  onVote: (v: number) => void = (v: number) => {}

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          UpVoteArrow({ color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .rotate({ angle: 180 })
        }
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .width(60) // 放宽投票区域

      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.post.body)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)

        Row({ space: AppTokens.Spacing.xl }) {
          InfoChip({ text: this.post.commentCount.toString() + ' Comments' })
          InfoChip({ text: 'Share' })
        }
        .padding({ top: AppTokens.Spacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', ''), '', '', 0)

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Rect()
        .width(3) // 增大
        .fill(this.reply.author.avatarColor)
        .fillOpacity(0.5)
        .borderRadius(1.5)
        .alignSelf(ItemAlign.Stretch)

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: this.reply.votes.toString() + ' votes' })
          InfoChip({ text: 'Reply' })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}

@Component
struct TopAppBar {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack() {
      Rect()
        .width('100%')
        .height(60) // 增大
        .fill(AppTokens.Colors.surface)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      Row() {
        Button() {
          Stack() {
            Canvas(this.context)
              .width(24)
              .height(24) // 增大
              .onReady(() => {
                this.context.strokeStyle = AppTokens.Colors.primary
                this.context.lineWidth = 3 // 增大
                let centerY = 12

                this.context.beginPath()
                this.context.moveTo(0, centerY)
                this.context.lineTo(24, centerY)
                this.context.stroke()

                this.context.beginPath()
                this.context.moveTo(0, centerY)
                this.context.lineTo(12, 0)
                this.context.stroke()

                this.context.beginPath()
                this.context.moveTo(0, centerY)
                this.context.lineTo(12, 24)
                this.context.stroke()
              })
          }
          .width(50)
          .height(50) // 增大
        }

        Blank()

        Text('r/jetpackcompose')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Rect()
          .width(50)
          .height(50) // 增大
          .fill('#00000000')
      }
      .width('100%')
      .height(60)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    Column({ space: 0 }) {
      Rect()
        .width('100%')
        .height(1) // 增大
        .fill(AppTokens.Colors.outline)
        .fillOpacity(0.3)
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row({ space: AppTokens.Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(52) // 增大
            .fill(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)

          if (this.commentText === '') {
            Text('Add a comment...')
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.outline)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }

          TextInput({ placeholder: '', text: this.commentText })
            .width('100%')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .onChange((value: string) => {
              this.commentText = value
            })
        }
        .layoutWeight(1)

        Button() {
          Text('POST')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .height(52) // 增大
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .onClick(() => {})
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''

  private post: Post = new Post(
    new Author('user/compose_master', AppTokens.Colors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppTokens.Colors.secondary), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppTokens.Colors.primary), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ]

  build() {
    Column({ space: 0 }) {
      TopAppBar()

      Scroll() {
        Column({ space: 0 }) {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })

          Text('TOP COMMENTS')
            .fontSize(AppTokens.Typography.small.size)
            .fontWeight(AppTokens.Typography.small.weight)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({
                left: AppTokens.Spacing.lg,
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm
              })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ForumPostView.ets
// 截图请使用 DevEco Studio 的 Previewer / Simulator 运行本页面获取。

/* ---------------- Design Tokens ---------------- */

class AppColors {
  static readonly primary: string = '#FF00E5FF'
  static readonly secondary: string = '#FFFF00AA'
  static readonly tertiary: string = '#FF76FF03'
  static readonly background: string = '#FF101024'
  static readonly surface: string = '#FF1C1C3A'
  static readonly surfaceVariant: string = '#FF282850'
  static readonly outline: string = '#FF44446A'
  static readonly warning: string = '#FFFFD600'
  static readonly onPrimary: string = '#FF000000'
  static readonly onSurface: string = '#FFE0E0FF'
}

class AppTypography {
  static readonly titleSize: number = 20
  static readonly headlineSize: number = 22
  static readonly bodySize: number = 18
  static readonly labelSize: number = 16
  static readonly smallSize: number = 14
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
  static readonly xs: number = 6
  static readonly sm: number = 10
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
}

/* ---------------- Models ---------------- */

class Author {
  name: string
  avatarColor: string

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number,
    commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

class Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

/* ---------------- Helpers ---------------- */

function formatVotes(value: number): string {
  const raw: string = Math.trunc(value).toString()
  let result: string = ''
  let count: number = 0
  for (let i = raw.length - 1; i >= 0; i--) {
    result = raw.charAt(i) + result
    count++
    if (count % 3 === 0 && i > 0) {
      result = ',' + result
    }
  }
  return result
}

// '#AARRGGBB' -> 带指定透明度的颜色
function withAlpha(color: string, alpha: number): string {
  const a: number = Math.round(alpha * 255)
  const hex: string = (a < 16 ? '0' : '') + a.toString(16).toUpperCase()
  return '#' + hex + color.substring(3)
}

/* ---------------- Small Components ---------------- */

@Component
struct UpVoteArrow {
  @Prop color: string = AppColors.outline

  build() {
    Path({ width: 28, height: 28, commands: 'M14 0 L28 14 L14 28 L0 14 Z' })
      .fill(this.color)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', '#FFFFFFFF')
  timestamp: string = ''

  build() {
    Row({ space: AppSpacing.sm }) {
      Stack() {
        Circle().width(28).height(28).fill(this.author.avatarColor)
        Circle().width(10).height(10).fill('#33000000')
      }

      Text(this.author.name)
        .fontSize(AppTypography.smallSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTypography.smallSize)
        .fontColor(AppColors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop text: string = ''

  build() {
    Text(this.text)
      .fontSize(AppTypography.smallSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
  }
}

/* ---------------- Cards ---------------- */

@Component
struct PostCard {
  post: Post = new Post(new Author('', '#FFFFFFFF'), '', '', '', 0, 0)
  @Prop voteState: number = 1
  onVote: (vote: number) => void = (vote: number) => {
  }

  build() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        UpVoteArrow({ color: this.voteState === 1 ? AppColors.secondary : AppColors.outline })
          .onClick(() => {
            this.onVote(this.voteState === 1 ? 0 : 1)
          })

        Text(formatVotes(this.post.votes + this.voteState - 1))
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)

        UpVoteArrow({ color: this.voteState === -1 ? AppColors.primary : AppColors.outline })
          .rotate({ angle: 180 })
          .onClick(() => {
            this.onVote(this.voteState === -1 ? 0 : -1)
          })
      }
      .width(72)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(this.post.body)
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onSurface)
          .opacity(0.8)
          .width('100%')
          .textAlign(TextAlign.Start)

        Row({ space: AppSpacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: AppSpacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', '#FFFFFFFF'), '', '', 0)

  build() {
    Column({ space: AppSpacing.xs }) {
      AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

      Text(this.reply.text)
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .opacity(0.9)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: AppSpacing.md }) {
        InfoChip({ text: `${this.reply.votes} votes` })
        InfoChip({ text: 'Reply' })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: AppSpacing.md,
      top: AppSpacing.xs,
      right: 0,
      bottom: AppSpacing.xs
    })
    .borderWidth({ left: 3 })
    .borderColor({ left: withAlpha(this.reply.author.avatarColor, 0.5) })
    .borderRadius(1.5)
    .margin({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
  }
}

/* ---------------- Bars ---------------- */

@Component
struct TopAppBar {
  build() {
    Row() {
      Stack() {
        Path({ width: 24, height: 24, commands: 'M24 12 L0 12 M0 12 L12 0 M0 12 L12 24' })
          .fill(Color.Transparent)
          .stroke(AppColors.primary)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
      }
      .width(50)
      .height(50)
      .onClick(() => {
      })

      Blank()

      Text('r/jetpackcompose')
        .fontSize(AppTypography.titleSize)
        .fontColor(AppColors.onSurface)

      Blank()

      Row()
        .width(50)
        .height(50)
    }
    .width('100%')
    .height(60)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    Column() {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(withAlpha(AppColors.outline, 0.3))

      Row({ space: AppSpacing.md }) {
        TextInput({ text: this.commentText, placeholder: 'Add a comment...' })
          .placeholderColor(AppColors.outline)
          .placeholderFont({ size: AppTypography.bodySize, weight: FontWeight.Normal })
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .height(52)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.commentText = value
          })

        Button() {
          Text('POST')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Normal)
        .height(52)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
  }
}

/* ---------------- Screen ---------------- */

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''

  private post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, ' +
      "it's becoming a new standard for prototypes and minimalist apps. " +
      'What are your thoughts on this approach?',
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppColors.secondary), '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppColors.primary), '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components ' +
        'is a game-changer for consistency.', 18)
  ]

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })

          Text('TOP COMMENTS')
            .fontSize(AppTypography.smallSize)
            .fontColor(AppColors.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "008_EducationQuiz_en"
private const val UI_TYPE = "Education Quiz"
private const val STYLE_THEME = "Playful Pastel"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF7C3AED)
        val secondary = Color(0xFF22C55E)
        val tertiary = Color(0xFFF97316)
        val background = Color(0xFFFAFAFF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF1F5F9)
        val outline = Color(0xFFE2E8F0)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF0F172A)
        val onTertiary = Color(0xFF111827)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, lineHeight = 30.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, lineHeight = 24.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 4.dp
        val md = 6.dp
        val lg = 8.dp
        val xl = 12.dp
        val xxl = 16.dp
        val xxxl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 0.5.dp, 0.12f)
        val level2 = ShadowSpec(2.dp, 4.dp, 1.dp, 0.14f)
        val level3 = ShadowSpec(3.dp, 6.dp, 1.5.dp, 0.16f)
        val level4 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.2f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class QuestionUi(val id: Int, val title: String, val options: List<String>, val answer: Int)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val questions = remember {
        listOf(
            QuestionUi(1, "Which planet is known as the Red Planet?", listOf("Earth", "Mars", "Venus", "Jupiter"), 1),
            QuestionUi(2, "What is the chemical symbol for water?", listOf("H2O", "CO2", "NaCl", "O2"), 0),
            QuestionUi(3, "Who wrote Hamlet?", listOf("Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"), 2),
            QuestionUi(4, "What is the largest mammal?", listOf("African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"), 1)
        )
    }
    val index = remember { mutableIntStateOf(0) }
    val selected = remember { mutableStateOf(-1) }
    val score = remember { mutableIntStateOf(0) }
    val completed = remember { mutableStateOf(false) }
    val flags = remember { mutableStateListOf<String>() }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                        Box(modifier = Modifier.size(20.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                        Text(text = "Quiz", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                    }
                }
            )
        },
        bottomBar = {
            Surface(color = MaterialTheme.colorScheme.surface, tonalElevation = AppTokens.ElevationMapping.level3.elevation, shadowElevation = AppTokens.ElevationMapping.level3.elevation) {
                Row(modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                        Text(text = "Progress", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        LinearProgressIndicator(progress = if (completed.value) 1f else (index.intValue + if (selected.value >= 0) 1 else 0).toFloat() / questions.size.toFloat(), modifier = Modifier.width(140.dp).height(6.dp), trackColor = AppTokens.Colors.surfaceVariant, color = MaterialTheme.colorScheme.primary)
                    }
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                        AssistChip(onClick = { if (flags.contains("Review")) flags.remove("Review") else flags.add("Review") }, label = { Text(text = "Review", style = MaterialTheme.typography.labelMedium, color = if (flags.contains("Review")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = if (flags.contains("Review")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface))
                        Button(onClick = {
                            if (!completed.value) {
                                if (selected.value == questions[index.intValue].answer) score.intValue = score.intValue + 1
                                if (index.intValue < questions.lastIndex) {
                                    index.intValue = index.intValue + 1
                                    selected.value = -1
                                } else {
                                    completed.value = true
                                }
                            }
                        }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary), shape = AppTokens.Shapes.large, modifier = Modifier.height(44.dp).width(140.dp)) {
                            Text(text = if (index.intValue < questions.lastIndex) "Next" else if (!completed.value) "Finish" else "Done", style = MaterialTheme.typography.titleMedium)
                        }
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        if (completed.value) {
            Column(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.xl), verticalArrangement = Arrangement.Center, horizontalAlignment = Alignment.CenterHorizontally) {
                Text(text = "Quiz Completed", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
                Box(modifier = Modifier.fillMaxWidth().heightIn(min = 120.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.large), contentAlignment = Alignment.Center) {
                    Text(text = "Score: ${score.intValue}/${questions.size}", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.primary)
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
                Button(onClick = { index.intValue = 0; selected.value = -1; score.intValue = 0; completed.value = false }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary, contentColor = MaterialTheme.colorScheme.onSecondary), shape = AppTokens.Shapes.large, modifier = Modifier.fillMaxWidth().height(44.dp)) {
                    Text(text = "Restart", style = MaterialTheme.typography.titleMedium)
                }
            }
        } else {
            LazyColumn(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)) {
                item {
                    Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 180.dp)) {
                        Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), horizontalAlignment = Alignment.Start) {
                            Box(modifier = Modifier.fillMaxWidth().aspectRatio(2.8f).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium), contentAlignment = Alignment.Center) {
                                Text(text = "Question ${index.intValue + 1}/${questions.size}", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                            Text(text = questions[index.intValue].title, style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                            Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), horizontalAlignment = Alignment.Start) {
                                questions[index.intValue].options.forEachIndexed { i, t ->
                                    val active = selected.value == i
                                    FilterChip(selected = active, onClick = { selected.value = i }, label = { Text(text = t, style = if (active) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium, color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface) }, colors = FilterChipDefaults.filterChipColors(containerColor = if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface, selectedContainerColor = MaterialTheme.colorScheme.primary), shape = AppTokens.Shapes.medium, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline))
                                }
                            }
                        }
                    }
                }
                item {
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                            Text(text = "Selected", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                            Text(text = if (selected.value >= 0) questions[index.intValue].options[selected.value] else "None", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        }
                        AssistChip(onClick = {}, label = { Text(text = "Skip", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.surface))
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF, widthDp = 360, heightDp = 640)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
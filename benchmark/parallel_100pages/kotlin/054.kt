package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
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

private const val NAME = "079_HomeworkSubmit_en"
private const val UI_TYPE = "Education Chart"
private const val STYLE_THEME = "Cold Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF0EA5E9)
        val secondary = Color(0xFF6366F1)
        val tertiary = Color(0xFF06B6D4)
        val background = Color(0xFFF1F5F9)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE2E8F0)
        val outline = Color(0xFFD1D5DB)
        val success = Color(0xFF10B981)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF0F172A)
        val onBackground = Color(0xFF1E293B)
        val onSurface = Color(0xFF1E293B)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 20.dp
        val xxl = 28.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 4.dp, 2.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 6.dp, 3.dp, 0.16f)
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
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class Homework(val id: Int, val title: String, val status: String)
data class ChartData(val id: Int, val label: String, val progress: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val works = remember {
        listOf(
            Homework(1, "Linear Algebra HW1", "Submitted"),
            Homework(2, "Data Structures HW2", "Pending"),
            Homework(3, "Algorithm HW3", "Graded"),
            Homework(4, "Probability HW4", "Pending")
        )
    }
    val charts = remember {
        mutableStateListOf(
            ChartData(1, "Week 1", 0.7f),
            ChartData(2, "Week 2", 0.9f),
            ChartData(3, "Week 3", 0.5f),
            ChartData(4, "Week 4", 0.8f)
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Homework Submit", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onBackground) }
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(
                    Brush.verticalGradient(
                        listOf(AppTokens.Colors.primary.copy(alpha = 0.15f), AppTokens.Colors.secondary.copy(alpha = 0.1f))
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Assignments", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onBackground)
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                contentPadding = PaddingValues(bottom = AppTokens.Spacing.lg)
            ) {
                items(works) { w ->
                    Card(
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        modifier = Modifier
                            .fillMaxWidth()
                            .aspectRatio(1f)
                            .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxSize()
                                .padding(AppTokens.Spacing.md),
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Box(
                                modifier = Modifier.size(40.dp).background(AppTokens.Colors.tertiary, AppTokens.Shapes.small)
                            )
                            Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                            Text(w.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            Text(w.status, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        }
                    }
                }
            }
            Text("Progress Chart", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onBackground)
            LazyColumn(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                items(charts.size) { i ->
                    val c = charts[i]
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(24.dp)
                            .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small)
                    ) {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth(c.progress)
                                .background(AppTokens.Colors.primary, AppTokens.Shapes.small)
                        )
                    }
                    Text("${c.label}: ${(c.progress * 100).toInt()}%", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                }
            }
            Button(
                onClick = {},
                modifier = Modifier.align(Alignment.CenterHorizontally).height(40.dp).fillMaxWidth(0.6f),
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary)
            ) {
                Text("Submit New HW", style = MaterialTheme.typography.titleMedium)
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
        controller.hide(WindowInsetsCompat.Type.systemBars())
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
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}

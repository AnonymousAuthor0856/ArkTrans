package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Configuration for Immersive Mode (Hide System Bars)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Apply a material theme wrapper, but force light colors for the requirement
            MaterialTheme(
                colorScheme = androidx.compose.material3.lightColorScheme(
                    background = Color.White,
                    surface = Color.White,
                    primary = Color(0xFF6D4C41), // Brownish tea color
                    secondary = Color(0xFFA1887F),
                    onPrimary = Color.White
                )
            ) {
                TeaBrewingScreen()
            }
        }
    }
}

@Composable
fun TeaBrewingScreen() {
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = Color.White // Global White Background Constraint
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Top Header
            HeaderSection()

            Spacer(modifier = Modifier.height(32.dp))

            // Main Card displaying the selected Tea
            TeaSelectionCard()

            Spacer(modifier = Modifier.height(32.dp))

            // Timer Visualization
            TimerDisplay(time = "02:00")

            Spacer(modifier = Modifier.height(40.dp))

            // Action Buttons
            ControlButtons()

            Spacer(modifier = Modifier.weight(1f))

            // Preparation Steps
            PreparationSteps()
        }
    }
}

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "Good Morning,",
                style = MaterialTheme.typography.bodyMedium,
                color = Color.Gray
            )
            Text(
                text = "Tea Master",
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold,
                color = Color.Black
            )
        }
        IconButton(
            onClick = { },
            modifier = Modifier
                .size(48.dp)
                .background(Color(0xFFF5F5F5), CircleShape)
        ) {
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = "Settings",
                tint = Color.Black
            )
        }
    }
}

@Composable
fun TeaSelectionCard() {
    Card(
        colors = CardDefaults.cardColors(containerColor = Color(0xFFFAFAFA)),
        border = BorderStroke(1.dp, Color(0xFFEEEEEE)),
        shape = RoundedCornerShape(24.dp),
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(20.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Abstract Tea Icon drawn with Canvas
            Box(
                modifier = Modifier
                    .size(60.dp)
                    .background(Color(0xFFEFEBE9), CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Canvas(modifier = Modifier.size(30.dp)) {
                    // Draw a simple leaf shape
                    drawCircle(
                        color = Color(0xFF6D4C41),
                        radius = size.minDimension / 2,
                        style = Stroke(width = 2.dp.toPx())
                    )
                    drawLine(
                        color = Color(0xFF6D4C41),
                        start = Offset(size.width / 2, size.height / 4),
                        end = Offset(size.width / 2, size.height * 0.75f),
                        strokeWidth = 2.dp.toPx(),
                        cap = StrokeCap.Round
                    )
                }
            }

            Spacer(modifier = Modifier.width(16.dp))

            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = "Earl Grey Reserve",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black
                )
                Text(
                    text = "Black Tea • 95°C",
                    style = MaterialTheme.typography.bodySmall,
                    color = Color(0xFF8D6E63)
                )
            }

            Icon(
                imageVector = Icons.Default.Favorite,
                contentDescription = "Favorite",
                tint = Color(0xFFFFCDD2) // Light red tint
            )
        }
    }
}

@Composable
fun TimerDisplay(time: String) {
    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier.size(220.dp)
    ) {
        // Outer Progress Ring
        Canvas(modifier = Modifier.fillMaxSize()) {
            drawCircle(
                color = Color(0xFFF5F5F5),
                style = Stroke(width = 12.dp.toPx())
            )
            drawArc(
                color = Color(0xFF6D4C41),
                startAngle = -90f,
                sweepAngle = 240f,
                useCenter = false,
                style = Stroke(width = 12.dp.toPx(), cap = StrokeCap.Round)
            )
        }

        // Inner Content
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = "Steeping",
                style = MaterialTheme.typography.labelMedium,
                color = Color.Gray,
                letterSpacing = 2.sp
            )
            Text(
                text = time,
                style = MaterialTheme.typography.displayMedium,
                fontWeight = FontWeight.Light,
                color = Color.Black
            )
        }
    }
}

@Composable
fun ControlButtons() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.Center,
        verticalAlignment = Alignment.CenterVertically
    ) {
        // Reset Button
        OutlinedButton(
            onClick = { },
            shape = CircleShape,
            modifier = Modifier.size(60.dp),
            border = BorderStroke(1.dp, Color(0xFFE0E0E0)),
            contentPadding = androidx.compose.foundation.layout.PaddingValues(0.dp)
        ) {
            Icon(
                imageVector = Icons.Default.Refresh,
                contentDescription = "Reset",
                tint = Color.Gray
            )
        }

        Spacer(modifier = Modifier.width(24.dp))

        // Play/Pause Button
        Button(
            onClick = { },
            shape = RoundedCornerShape(24.dp),
            modifier = Modifier
                .height(60.dp)
                .width(120.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFF6D4C41)
            )
        ) {
            Icon(
                imageVector = Icons.Default.PlayArrow,
                contentDescription = "Start",
                modifier = Modifier.padding(end = 8.dp)
            )
            Text(text = "Start")
        }

        Spacer(modifier = Modifier.width(24.dp))

        // Add Note Button
        OutlinedButton(
            onClick = { },
            shape = CircleShape,
            modifier = Modifier.size(60.dp),
            border = BorderStroke(1.dp, Color(0xFFE0E0E0)),
            contentPadding = androidx.compose.foundation.layout.PaddingValues(0.dp)
        ) {
            Icon(
                imageVector = Icons.Default.Add,
                contentDescription = "Add Note",
                tint = Color.Gray
            )
        }
    }
}

@Composable
fun PreparationSteps() {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = "PREPARATION",
            style = MaterialTheme.typography.labelSmall,
            fontWeight = FontWeight.Bold,
            color = Color.LightGray,
            modifier = Modifier.padding(bottom = 12.dp)
        )

        StepItem(step = "1", text = "Boil fresh water to 95°C")
        StepItem(step = "2", text = "Add 1 tsp of loose leaf per cup")
        StepItem(step = "3", text = "Pour water and wait for timer")
    }
}

@Composable
fun StepItem(step: String, text: String) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(24.dp)
                .background(Color(0xFFF5F5F5), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = step,
                style = MaterialTheme.typography.labelSmall,
                color = Color.Black,
                fontWeight = FontWeight.Bold
            )
        }
        Spacer(modifier = Modifier.width(12.dp))
        Text(
            text = text,
            style = MaterialTheme.typography.bodyMedium,
            color = Color.DarkGray
        )
        Spacer(modifier = Modifier.weight(1f))
        Icon(
            imageVector = Icons.Default.Check,
            contentDescription = null,
            tint = Color(0xFFEEEEEE),
            modifier = Modifier.size(16.dp)
        )
    }
    HorizontalDivider(color = Color(0xFFFAFAFA))
}

@Preview(showBackground = true, widthDp = 360, heightDp = 800)
@Composable
fun PreviewTeaApp() {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            background = Color.White,
            surface = Color.White
        )
    ) {
        TeaBrewingScreen()
    }
}
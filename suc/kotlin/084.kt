package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
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
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Enable Edge-to-Edge
        enableEdgeToEdge()

        // 2. Hide System Navigation Bar and Status Bar (Immersive Sticky)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Using default Material Theme but forcing light/white aesthetic
            MaterialTheme(
                colorScheme = MaterialTheme.colorScheme.copy(
                    background = Color.White,
                    surface = Color.White,
                    primary = Color.Black,
                    onPrimary = Color.White
                )
            ) {
                BrewingScreen()
            }
        }
    }
}

// Data model for a brewing step
data class BrewStep(
    val title: String,
    val description: String,
    val waterTarget: String,
    val time: String,
    val isCompleted: Boolean = false
)

@Composable
fun BrewingScreen() {
    // Hardcoded data for pure UI demonstration
    val steps = listOf(
        BrewStep("Bloom", "Wet the grounds evenly to release CO2.", "60g", "0:00 - 0:45", true),
        BrewStep("First Pour", "Pour slowly in concentric circles.", "180g", "0:45 - 1:30", false),
        BrewStep("Second Pour", "Gently pour remaining water.", "300g", "1:30 - 2:15", false),
        BrewStep("Draw Down", "Wait for the water to drain completely.", "300g", "2:15 - 3:00", false)
    )

    Scaffold(
        containerColor = Color.White,
        topBar = {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 24.dp, vertical = 48.dp), // Large top padding for safe area
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "V60 Guide",
                        style = MaterialTheme.typography.headlineMedium.copy(
                            fontWeight = FontWeight.Bold,
                            letterSpacing = (-0.5).sp
                        ),
                        color = Color.Black
                    )
                    Text(
                        text = "Ethiopia Yirgacheffe",
                        style = MaterialTheme.typography.bodyMedium,
                        color = Color.Gray
                    )
                }
                IconButton(onClick = {}) {
                    Icon(
                        imageVector = Icons.Default.Settings,
                        contentDescription = "Settings",
                        tint = Color.Black
                    )
                }
            }
        },
        bottomBar = {
            // Bottom Control Area
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(24.dp),
                contentAlignment = Alignment.Center
            ) {
                Button(
                    onClick = {},
                    modifier = Modifier
                        .height(64.dp)
                        .fillMaxWidth(),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color.Black,
                        contentColor = Color.White
                    ),
                    shape = RoundedCornerShape(16.dp)
                ) {
                    Icon(Icons.Default.PlayArrow, contentDescription = null)
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "Start Brewing",
                        style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                    )
                }
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .fillMaxSize()
                .padding(horizontal = 24.dp)
        ) {
            // Main Timer Display
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 24.dp),
                contentAlignment = Alignment.Center
            ) {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Text(
                        text = "00:45",
                        style = MaterialTheme.typography.displayLarge.copy(
                            fontSize = 80.sp,
                            fontWeight = FontWeight.Light,
                            fontFamily = FontFamily.Monospace,
                            letterSpacing = (-2).sp
                        ),
                        color = Color.Black
                    )
                    Text(
                        text = "Target: 300g",
                        style = MaterialTheme.typography.labelLarge,
                        color = Color.Gray
                    )
                }
            }

            // Stats Row
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 32.dp),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                StatItem(label = "Ratio", value = "1:15")
                StatItem(label = "Beans", value = "20g")
                StatItem(label = "Temp", value = "93°C")
            }

            HorizontalDivider(color = Color(0xFFF0F0F0))
            Spacer(modifier = Modifier.height(24.dp))

            Text(
                text = "Brewing Steps",
                style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold),
                modifier = Modifier.padding(bottom = 16.dp)
            )

            // Steps List
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier.weight(1f) // Fill remaining space
            ) {
                itemsIndexed(steps) { index, step ->
                    StepCard(index + 1, step)
                }
                // Add some bottom padding for the scrolling list so it clears the button
                item {
                    Spacer(modifier = Modifier.height(80.dp))
                }
            }
        }
    }
}

@Composable
fun StatItem(label: String, value: String) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Box(
            modifier = Modifier
                .size(48.dp)
                .border(1.dp, Color(0xFFE0E0E0), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            // Visual variety: different icons or just simple typography
            when (label) {
                "Ratio" -> Icon(Icons.Default.Add, contentDescription = null, modifier = Modifier.size(20.dp), tint = Color.Gray)
                "Beans" -> Icon(Icons.Default.Favorite, contentDescription = null, modifier = Modifier.size(20.dp), tint = Color.Gray)
                else -> Icon(Icons.Default.Refresh, contentDescription = null, modifier = Modifier.size(20.dp), tint = Color.Gray)
            }
        }
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = value,
            style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.SemiBold),
            color = Color.Black
        )
        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = Color.Gray
        )
    }
}

@Composable
fun StepCard(number: Int, step: BrewStep) {
    val containerColor = if (step.isCompleted) Color(0xFFF8F8F8) else Color.White
    val borderColor = if (step.isCompleted) Color.Transparent else Color(0xFFEEEEEE)
    val textColor = if (step.isCompleted) Color.Gray else Color.Black

    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.Top
    ) {
        // Timeline Indicator
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.padding(end = 16.dp, top = 4.dp)
        ) {
            Box(
                modifier = Modifier
                    .size(24.dp)
                    .background(
                        if (step.isCompleted) Color.Black else Color(0xFFE0E0E0),
                        CircleShape
                    ),
                contentAlignment = Alignment.Center
            ) {
                if (step.isCompleted) {
                    Icon(
                        Icons.Default.Check,
                        contentDescription = null,
                        tint = Color.White,
                        modifier = Modifier.size(14.dp)
                    )
                } else {
                    Text(
                        text = number.toString(),
                        style = MaterialTheme.typography.labelSmall,
                        color = Color.White
                    )
                }
            }
            // Vertical line connection visual (simplified)
            Box(
                modifier = Modifier
                    .width(1.dp)
                    .height(60.dp)
                    .background(Color(0xFFF0F0F0))
            )
        }

        // Content Card
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(containerColor = containerColor),
            shape = RoundedCornerShape(12.dp),
            border = androidx.compose.foundation.BorderStroke(1.dp, borderColor)
        ) {
            Column(modifier = Modifier.padding(16.dp)) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(
                        text = step.title,
                        style = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.Bold),
                        color = textColor
                    )
                    Text(
                        text = step.waterTarget,
                        style = MaterialTheme.typography.bodyMedium.copy(
                            fontWeight = FontWeight.Bold,
                            fontFamily = FontFamily.Monospace
                        ),
                        color = if (step.isCompleted) textColor else Color.Black
                    )
                }
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = step.description,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.Gray
                )
                Spacer(modifier = Modifier.height(8.dp))
                Box(
                    modifier = Modifier
                        .clip(RoundedCornerShape(4.dp))
                        .background(Color(0xFFF5F5F5))
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                ) {
                    Text(
                        text = step.time,
                        style = MaterialTheme.typography.labelSmall,
                        color = Color.Gray
                    )
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewBrewingScreen() {
    MaterialTheme(
        colorScheme = MaterialTheme.colorScheme.copy(
            background = Color.White,
            surface = Color.White
        )
    ) {
        BrewingScreen()
    }
}